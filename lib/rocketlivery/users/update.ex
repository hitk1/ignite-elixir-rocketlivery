defmodule Rocketlivery.Users.Update do
  alias Ecto.UUID
  alias Rocketlivery.{Repo, User, Error}

  # Primeiro é necessário validar se o id recebido como paremtro é um id valido (uuid valido)
  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_if_format_error()}
      {:ok, _uuid} -> update(params)
    end
  end

  defp update(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found()}
      user -> do_update(user, params)
    end
  end

  defp do_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
