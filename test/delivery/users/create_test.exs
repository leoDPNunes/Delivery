defmodule Delivery.Users.CreateTest do
  use Delivery.DataCase, async: true

  alias Delivery.{Error, User}
  alias Delivery.Users.Create
  alias Delivery.ViaCep.ClientMock

  import Mox
  import Delivery.Factory

  describe "call/1" do
    setup :verify_on_exit!

    test "when all params are valid, returns the user" do
      params = build(:user_params)

      expect(ClientMock, :get_zipcode_info, fn _zipcode ->
        {:ok, build(:zipcode_info)}
      end)

      response = Create.call(params)

      assert {:ok, %User{id: _id, age: 33, cpf: "12345678901", email: "leonardoteste@teste.com"}} =
               response
    end

    test "when there are invalid params, returns an error" do
      params =
        build(:user_params, %{
          "zipcode" => "7654321",
          "cpf" => "1234567890",
          "password" => "12345"
        })

      response = Create.call(params)
      {:error, %Error{result: changeset}} = response

      expected_errors = %{
        zipcode: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        password: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request}} = response
      assert errors_on(changeset) == expected_errors
    end
  end
end
