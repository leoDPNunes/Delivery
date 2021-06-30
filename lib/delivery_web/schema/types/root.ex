defmodule DeliveryWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation

  alias Crudry.Middlewares.TranslateErrors
  alias DeliveryWeb.Resolvers.User, as: UserResolver

  import_types DeliveryWeb.Schema.Types.User

  object :root_query do
    field :get_user, type: :user do
      arg :id, non_null(:uuid4)

      resolve &UserResolver.get/2
    end
  end

  object :root_mutation do
    field :create_user, type: :user do
      arg :input, non_null(:user_input)

      resolve &UserResolver.create/2
      middleware TranslateErrors
    end

    field :delete_user, type: :user do
      arg :id, non_null(:uuid4)

      resolve &UserResolver.delete/2
    end

    field :update_user, type: :user do
      arg :id, non_null(:uuid4)
      arg :input, :user_input

      resolve &UserResolver.update/2
    end
  end
end
