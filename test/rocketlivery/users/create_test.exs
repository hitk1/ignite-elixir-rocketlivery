defmodule Rocketlivery.Users.CreateTest do
  use Rocketlivery.DataCase, async: true

  alias Rocketlivery.{Error, User}
  alias Rocketlivery.Users.Create
  alias Rocketlivery.ViaCep.ClientMock

  import Mox
  import Rocketlivery.Factory

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok,
         %{
           "age" => 24,
           "address" => "Rua teste do tste, 34",
           "cep" => "12345688",
           "cpf" => "12345678900",
           "email" => "test@mail.com",
           "password" => "123123",
           "name" => "Testing app"
         }}
      end)

      response = Create.call(params)

      assert {:ok, %User{id: _id, age: 24, email: "test@mail.com"}} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user_params, %{age: 15})

      response = Create.call(params)
      {:error, %Error{reason: changeset}} = response

      expected_response = %{age: ["must be greater than or equal to 18"]}

      assert errors_on(changeset) == expected_response
    end
  end
end
