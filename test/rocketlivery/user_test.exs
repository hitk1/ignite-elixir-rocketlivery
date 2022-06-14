defmodule Rocketlivery.UserTest do
  use Rocketlivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rocketlivery.User

  describe "changeset/2" do
    test "when all params are valid, returns the the changeset" do
      params = %{
        age: 24,
        address: "Rua teste do tste, 34",
        cep: "12345688",
        cpf: "12345678900",
        email: "test@mail.com",
        password: "123123",
        name: "Testing app"
      }

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Testing app"}, valid?: true} = response
    end

    test "when updating a changeset, return a valid changeset with the giver changes" do
      params = %{
        age: 24,
        address: "Rua teste do tste, 34",
        cep: "12345688",
        cpf: "12345678900",
        email: "test@mail.com",
        password: "123123",
        name: "Testing app"
      }

      new_params = %{name: "Testing update params"}

      response =
        params
        |> User.changeset()
        |> User.changeset(new_params)

      assert %Changeset{changes: %{name: "Testing update params"}, valid?: true} = response
    end
  end
end
