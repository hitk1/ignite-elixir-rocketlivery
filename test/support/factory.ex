defmodule Rocketlivery.Factory do
  use ExMachina

  def user_params_factory do
    %{
      age: 24,
      address: "Rua teste do tste, 34",
      cep: "12345688",
      cpf: "12345678900",
      email: "test@mail.com",
      password: "123123",
      name: "Testing app"
    }
  end
end
