defmodule Delivery.UserTest do
  use Delivery.DataCase, async: true

  alias Ecto.Changeset
  alias Delivery.User

  import Delivery.Factory

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "leonardo nunes"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)
      changeset = User.changeset(params)

      update_params = %{name: "joão", password: "123456"}

      response = User.changeset(changeset, update_params)

      assert %Changeset{changes: %{name: "joão"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:user_params, %{"password" => "123"})

      response = User.changeset(params)

      expected_response = %{password: ["should be at least 6 character(s)"]}

      assert errors_on(response) == expected_response
    end
  end
end
