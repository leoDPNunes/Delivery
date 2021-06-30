defmodule DeliveryWeb.UsersView do
  use DeliveryWeb, :view

  alias Delivery.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      message: "User Created!",
      token: token,
      user: user
    }
  end

  def render("sign_in.json", %{token: token}), do: %{token: token}

  def render("user.json", %{user: %User{} = user}), do: %{user: user}
end
