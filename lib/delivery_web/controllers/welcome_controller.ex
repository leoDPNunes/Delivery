defmodule DeliveryWeb.WelcomeController do
  use DeliveryWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("welcome :)")
  end
end
