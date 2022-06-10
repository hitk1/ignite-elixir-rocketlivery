defmodule Rocketlivery do
  alias Rocketlivery.Users.Create, as: CreateUser

  defdelegate create_user(params), to: CreateUser, as: :call
end
