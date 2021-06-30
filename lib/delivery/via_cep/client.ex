defmodule Delivery.ViaCep.Client do
  use Tesla

  alias Delivery.{Error, ViaCep.Behaviour}
  alias Tesla.Env

  @behaviour Behaviour

  @base_url "https://viacep.com.br/ws/"
  plug Tesla.Middleware.JSON

  def get_zipcode_info(url \\ @base_url, zipcode) do
    "#{url}#{zipcode}/json/"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"erro" => true}}}) do
    build_error(:not_found, "Zipcode not found!")
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Env{status: 400, body: _body}}) do
    build_error(:bad_request, "Invalid Zipcode!")
  end

  defp handle_get({:error, reason}) do
    build_error(:bad_request, reason)
  end

  defp build_error(status, result), do: {:error, Error.build(status, result)}
end
