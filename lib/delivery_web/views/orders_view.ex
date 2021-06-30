defmodule DeliveryWeb.OrdersView do
  use DeliveryWeb, :view

  alias Delivery.Order

  def render("create.json", %{order: %Order{} = order}) do
    %{
      message: "Order Created!",
      order: order
    }
  end
end
