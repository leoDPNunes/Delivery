defmodule Delivery.Factory do
  use ExMachina.Ecto, repo: Delivery.Repo

  alias Delivery.User

  def user_params_factory do
    %{
      "address" => "1321 Whaley Street",
      "age" => 33,
      "zipcode" => "29208678",
      "cpf" => "12345678901",
      "email" => "leonardoteste@teste.com",
      "name" => "leonardo nunes",
      "password" => "123456"
    }
  end

  def user_factory do
    %User{
      address: "1321 Whaley Street",
      age: 33,
      zipcode: "29208678",
      cpf: "12345678901",
      email: "leonardoteste@teste.com",
      name: "leonardo nunes",
      id: "3889e9c8-5a2f-4e9f-ae0d-66678a5be7d7",
      password: "123456"
    }
  end

  def zipcode_info_factory do
    %{
      "bairro" => "Sé",
      "zipcode" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
