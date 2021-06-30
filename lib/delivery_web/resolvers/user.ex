defmodule DeliveryWeb.Resolvers.User do

  alias Delivery.Users

  def create(%{input: params}, _contex), do: Users.Create.call(params)

  def get(%{id: user_id}, _context), do: Users.Get.by_id(user_id)

  def update(%{id: user_id, input: params}, _context),
    do: Users.Update.call(user_id, params)

  def delete(%{id: user_id}, _context), do: Users.Delete.call(user_id)
end
