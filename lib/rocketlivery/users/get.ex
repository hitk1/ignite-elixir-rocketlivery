defmodule Rocketlivery.Users.Get do
  alias Ecto.UUID
  alias Rocketlivery.{Repo, User}

  # Primeiro é necessário validar se o id recebido como paremtro é um id valido (uuid valido)
  def by_id(id) do
    case UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, reason: "ID invalid format"}}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(id) do
    case Repo.get(User, id) do
      nil -> {:error, %{status: :not_found, reason: "User not found"}}
      user -> {:ok, user}
    end
  end
end
