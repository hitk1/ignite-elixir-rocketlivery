defmodule Rocketlivery do
  alias Rocketlivery.Items.Create, as: CreateItem

  alias Rocketlivery.Users.Create, as: CreateUser
  alias Rocketlivery.Users.Get, as: GetUser
  alias Rocketlivery.Users.Delete, as: DeleteUser
  alias Rocketlivery.Users.Update, as: UpdateUser

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
  defdelegate delete_user(id), to: DeleteUser, as: :call
  defdelegate update_user(params), to: UpdateUser, as: :call

  defdelegate create_item(params), to: CreateItem, as: :call
end
