defmodule Delivery.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Delivery.Order
  alias Ecto.Enum

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:category, :description, :price, :photo]

  @items_categories [:food, :drink, :dessert]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "items" do
    field :category, Enum, values: @items_categories
    field :description, :string
    field :price, :decimal
    field :photo, :string

    many_to_many :orders, Order, join_through: "orders_items"

    timestamps()
  end

  def changeset(changeset \\ %__MODULE__{}, params) do
    changeset
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than_or_equal_to: 0)
  end
end
