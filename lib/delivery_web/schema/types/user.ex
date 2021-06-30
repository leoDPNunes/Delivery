defmodule DeliveryWeb.Schema.Types.User do
  use Absinthe.Schema.Notation

  import_types DeliveryWeb.Schema.Types.Custom.UUID4

  @desc "Logic user representation"
  object :user do
    field :id, non_null(:uuid4)
    field :age, non_null(:integer)
    field :address, non_null(:string)
    field :zipcode, non_null(:string)
    field :cpf, non_null(:string)
    field :email, non_null(:string)
    field :name, non_null(:string)
  end

  input_object :user_input do
    field :age, non_null(:integer), description: "User's age"
    field :address, non_null(:string), description: "User's address"
    field :cpf, non_null(:string), description: "User's cpf"
    field :email, non_null(:string), description: "User's email"
    field :name, non_null(:string), description: "User's name"
    field :password, non_null(:string), description: "User's password"
    field :zipcode, non_null(:string), description: "User's cep"
  end
end
