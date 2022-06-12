defmodule Rocketlivery.Users.Delete do
  alias Ecto.UUID
  alias Rocketlivery.{Repo, User, Error}

  # Primeiro é necessário validar se o id recebido como paremtro é um id valido (uuid valido)
  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_id_format_error()}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found()}
      user -> Repo.delete(user)
    end
  end
end
