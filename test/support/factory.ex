defmodule Rocketlivery.Factory do
  use ExMachina.Ecto, repo: Rocketlivery.Repo

  alias Rocketlivery.User

  def user_params_factory do
    %{
      "age" => 24,
      "address" => "Rua teste do tste, 34",
      "cep" => "12345688",
      "cpf" => "12345678900",
      "email" => "test@mail.com",
      "password" => "123123",
      "name" => "Testing app"
    }
  end

  def user_factory do
    %User{
      id: "34998af8-9c2d-4961-a0d7-51666758cf2e",
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
