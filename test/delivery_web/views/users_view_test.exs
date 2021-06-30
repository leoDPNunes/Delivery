defmodule DeliveryWeb.UsersViewTest do
  use DeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Delivery.Factory

  alias Delivery.User
  alias DeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", token: "x3l2k89", user: user)

    assert %{
             message: "User Created!",
             token: "x3l2k89",
             user: %User{
               address: "1321 Whaley Street",
               age: 33,
               zipcode: "29208678",
               cpf: "12345678901",
               email: "leonardoteste@teste.com",
               name: "leonardo nunes",
               id: "3889e9c8-5a2f-4e9f-ae0d-66678a5be7d7",
               inserted_at: nil,
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end

  test "renders user.json" do
    user = build(:user)

    response = render(UsersView, "user.json", user: user)

    assert %{
             user: %User{
               address: "1321 Whaley Street",
               age: 33,
               zipcode: "29208678",
               cpf: "12345678901",
               email: "leonardoteste@teste.com",
               name: "leonardo nunes",
               id: "3889e9c8-5a2f-4e9f-ae0d-66678a5be7d7",
               inserted_at: nil,
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end
