defmodule Rocketlivery.Users.Create do
  alias Rocketlivery.{User, Repo, Error}
  alias Rocketlivery.ViaCep.Client, as: ViaCepClient

  def call(%{"cep" => cep} = params) do
    with {:ok, %User{} = user} <- User.build(params),
         {:ok, _cep_data} <- ViaCepClient.get_cep_info(cep) do
      Repo.insert(user)
    else
      {:error, %Error{}} = error -> error
      {:error, reason} -> {:error, Error.build(:bad_request, reason)}
    end
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
