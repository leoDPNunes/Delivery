defmodule Delivery.Users.Create do
  alias Delivery.{Error, Repo, User}

  def call(%{"zipcode" => zipcode} = params) do
    changeset = User.changeset(params)
    with {:ok, %User{}} <- User.build(changeset),
         {:ok, _zipcode_info} <- client().get_zipcode_info(zipcode),
         {:ok, %User{}} = user <- Repo.insert(changeset) do
      user
    else
      {:error, %Error{}} = error ->
        error

      {:error, result} ->
        {:error, Error.build(:bad_request, result)}
    end
  end

  def call(params) do
    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, %User{}} = user <- Repo.insert(changeset) do
      user
    else
      {:error, %Error{}} = error ->
        error

      {:error, result} ->
        {:error, Error.build(:bad_request, result)}
    end
  end

  defp client do
    :delivery
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:via_zipcode_adapter)
  end
end
