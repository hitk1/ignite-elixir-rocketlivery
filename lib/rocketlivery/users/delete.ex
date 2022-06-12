defmodule Rocketlivery.Users.Delete do
  alias Ecto.UUID
  alias Rocketlivery.{Repo, User}

  # Primeiro é necessário validar se o id recebido como paremtro é um id valido (uuid valido)
  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, reason: "ID invalid format"}}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(id) do
    case Repo.get(User, id) do
      nil -> {:error, %{status: :not_found, reason: "User not found"}}
      user -> Repo.delete(user)
    end
  end
end
