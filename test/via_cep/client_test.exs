defmodule Delivery.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  alias Delivery.Error
  alias Delivery.ViaCep.Client

  import Delivery.Factory

  describe "get_zipcode_info/1" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "when there is a valid zipcode, returns the zipcode info", %{bypass: bypass} do
      zipcode = "01001000"

      url = endpoint_url(bypass.port)

      body = ~s({
        "zipcode": "01001-000",
        "logradouro": "Praça da Sé",
        "complemento": "lado ímpar",
        "bairro": "Sé",
        "localidade": "São Paulo",
        "uf": "SP",
        "ibge": "3550308",
        "gia": "1004",
        "ddd": "11",
        "siafi": "7107"
      })

      Bypass.expect(bypass, "GET", "/#{zipcode}/json/", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      expected_response = {:ok, build(:zipcode_info)}

      response = Client.get_zipcode_info(url, zipcode)

      assert response == expected_response
    end

    test "when the zipcode is invalid, returns an error", %{bypass: bypass} do
      zipcode = "123"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "/#{zipcode}/json/", fn conn ->
        Conn.resp(conn, 400, "")
      end)

      expected_response = {:error, %Error{result: "Invalid Zipcode!", status: :bad_request}}

      response = Client.get_zipcode_info(url, zipcode)

      assert response == expected_response
    end

    test "when the zipcode is not found, returns an error", %{bypass: bypass} do
      zipcode = "00000000"

      body = ~s({"erro": true})

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "/#{zipcode}/json/", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      expected_response = {:error, %Error{result: "Zipcode not found!", status: :not_found}}

      response = Client.get_zipcode_info(url, zipcode)

      assert response == expected_response
    end

    test "when there is a generic error, returns the error", %{bypass: bypass} do
      zipcode = "01001000"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      expected_response = {:error, %Error{result: :econnrefused, status: :bad_request}}

      response = Client.get_zipcode_info(url, zipcode)

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
