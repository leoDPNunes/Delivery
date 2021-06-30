defmodule DeliveryWeb.SchemaTest do
  use DeliveryWeb.ConnCase, async: true

  alias Delivery.User
  alias Delivery.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{
        name: "tester",
        email: "test@email.com",
        password: "123456",
        age: 33,
        cpf: "11335577991",
        address: "230 sumter street",
        zipcode: "20222020"
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}") {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "test@email.com",
            "name" => "tester"
          }
        }
      }

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "developer",
            age: 33,
            address: "whaley street",
            zipcode: "20775002",
            cpf: "12345678912",
            email: "developer@email.com",
            password: "123456"
          }) {
              name,
              age
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "createUser" => %{
            "age" => 33,
            "name" => "developer"
          }
        }
      }

      assert response == expected_response
    end
  end
end
