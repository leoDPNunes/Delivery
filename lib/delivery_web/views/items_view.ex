defmodule DeliveryWeb.ItemsView do
  use DeliveryWeb, :view

  alias Delivery.Item

  def render("create.json", %{item: %Item{} = item}) do
    %{
      message: "Item Created!",
      item: item
    }
  end

  def render("item.json", %{item: %Item{} = item}), do: %{item: item}
end
