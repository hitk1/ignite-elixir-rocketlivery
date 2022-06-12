defmodule Rocketlivery.Users.Create do
  alias Rocketlivery.{User, Repo}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{} = user}), do: {:ok, user}

  defp handle_insert({:error, reason}) do
    {:error, %{status: :bad_request, reason: reason}}
  end
end
