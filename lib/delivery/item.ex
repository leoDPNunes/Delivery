defmodule Delivery.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Delivery.Order
  alias Ecto.Enum

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:category, :description, :price, :photo]

  @update_params [:category, :description, :price, :photo]

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

  def changeset(params) do
    fields = @required_params

    %__MODULE__{}
    |> changes(params, @required_params = fields)
  end

  def changeset(changeset \\ %__MODULE__{}, params) do
    fields = @update_params

    changeset
    |> changes(params, fields)
  end

  defp changes(changeset, params, fields) do
    changeset
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than_or_equal_to: 0)
  end
end
