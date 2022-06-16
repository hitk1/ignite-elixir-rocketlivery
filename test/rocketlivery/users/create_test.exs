defmodule Rocketlivery.Users.CreateTest do
  use Rocketlivery.DataCase, async: true
  alias Rocketlivery.{Error, User}
  alias Rocketlivery.Users.Create

  import Rocketlivery.Factory

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

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
