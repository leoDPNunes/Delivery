defmodule DeliveryWeb.UsersControllerTest do
  use DeliveryWeb.ConnCase, async: true

  alias Delivery.ViaCep.ClientMock
  alias DeliveryWeb.Auth.Guardian

  import Mox
  import Delivery.Factory

  describe "create/2" do
    setup :verify_on_exit!

    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      expect(ClientMock, :get_zipcode_info, fn _zipcode ->
        {:ok, build(:zipcode_info)}
      end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User Created!",
               "user" => %{
                 "address" => "1321 Whaley Street",
                 "age" => 33,
                 "zipcode" => "29208678",
                 "cpf" => "12345678901",
                 "email" => "leonardoteste@teste.com",
                 "id" => _id,
                 "name" => "leonardo nunes"
               }
             } = response
    end

    test "when there is an error, returns the error", %{conn: conn} do
      params = :user_params |> build() |> Map.drop(["name", "cpf"])

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{"cpf" => ["can't be blank"], "name" => ["can't be blank"]}
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when there is an user with the given id, deletes the user", %{conn: conn} do
      id = "3889e9c8-5a2f-4e9f-ae0d-66678a5be7d7"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end
end
