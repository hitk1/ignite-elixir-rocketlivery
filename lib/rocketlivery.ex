defmodule Rocketlivery do
  alias Rocketlivery.Users.Create, as: CreateUser
  alias Rocketlivery.Users.Get, as: GetUser

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
end
