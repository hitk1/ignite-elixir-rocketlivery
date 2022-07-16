defmodule Rocketlivery.Users.Create do
  alias Rocketlivery.{User, Repo, Error}
  alias Rocketlivery.ViaCep.Client, as: ViaCepClient

  def call(params) do
    cep = Map.get(params, "cep")

    with {:ok, %User{} = user} <- User.build(params),
         {:ok, _cep_data} <- client().get_cep_info(cep) do
      Repo.insert(user)
    else
      {:error, %Error{}} = error -> error
      {:error, reason} -> {:error, Error.build(:bad_request, reason)}
    end
  end

  defp client do
    # Le as configurações feitas no arquivo geral de configuraçoes para selecionar dados dinamicos
    :rocketlivery
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:via_cep_adapter)
  end

  # defp create_user(params) do
  #   params
  #   |> User.changeset()
  #   |> Repo.insert()
  #   |> handle_insert()
  # end

  # defp handle_insert({:ok, %User{}} = result), do: result

  # defp handle_insert({:error, reason}) do
  #   {:error, Error.build(:bad_request, reason)}
  # end
end
