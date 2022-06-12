defmodule Rocketlivery.Users.Get do
  alias Ecto.UUID
  alias Rocketlivery.{Repo, User, Error}

  # Primeiro é necessário validar se o id recebido como paremtro é um id valido (uuid valido)
  def by_id(id) do
    case UUID.cast(id) do
      :error -> %{:error, Error.build_id_format_error()}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(id) do
    case Repo.get(User, id) do
      nil -> %{:error, Error.build_user_not_found()}
      user -> {:ok, user}
    end
  end
end
