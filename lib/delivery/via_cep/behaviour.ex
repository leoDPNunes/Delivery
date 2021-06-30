defmodule Delivery.ViaCep.Behaviour do
  alias Delivery.Error

  @callback get_zipcode_info(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
