defmodule Rocketlivery.UserTest do
  use Rocketlivery.DataCase, async: true
  import Rocketlivery.Factory

  alias Ecto.Changeset
  alias Rocketlivery.User

  describe "changeset/2" do
    test "when all params are valid, returns the the changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Testing app"}, valid?: true} = response
    end

    test "when updating a changeset, return a valid changeset with the given changes" do
      params = build(:user_params)

      new_params = %{"name" => "Testing update params"}

      response =
        params
        |> User.changeset()
        |> User.changeset(new_params)

      assert %Changeset{changes: %{name: "Testing update params"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:user_params, %{"age" => 15, "password" => "123"})

      response = User.changeset(params)

      expected_response = %{age: ["must be greater than or equal to 18"]}

      assert errors_on(response) == expected_response
    end
  end
end
