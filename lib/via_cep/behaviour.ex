defmodule Rocketlivery.ViaCep.Behaviour do
  alias Rocketlivery.Error

  @callback get_cep_info(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
