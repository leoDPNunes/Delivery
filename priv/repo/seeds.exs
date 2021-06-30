# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Delivery.Repo.insert!(%Delivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Delivery.{Item, Order, Repo, User}

IO.puts("===== Inserting user... =====")

user = %User{
  age: 33,
  address: "1321 Whaley Street",
  zipcode: "29208678",
  cpf: "12345678901",
  email: 'leonardoteste@teste.com',
  password: "123456",
  name: "leonardo"
}

%User{id: user_id} = Repo.insert!(user)

IO.puts("===== Inserting items... =====")

item1 = %Item{
  category: :drink,
  description: "Guaraná",
  price: Decimal.new("9.90"),
  photo: "priv/photos/guarana.png"
}

item2 = %Item{
  category: :food,
  description: "Pizza Calabresa",
  price: Decimal.new("32.00"),
  photo: "priv/photos/pizza_calabresa.png"
}

Repo.insert!(item1)
Repo.insert!(item2)

IO.puts("===== Inserting orders... =====")

order = %Order{
  user_id: user_id,
  items: [item1, item1, item1, item2, item2],
  address: "1321 Whaley Street",
  comments: "Com borda recheada",
  payment_method: :credit_card
}

Repo.insert!(order)
IO.puts("===== DONE! =====")
