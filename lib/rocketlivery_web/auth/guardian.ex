defmodule RocketliveryWeb.Auth.Guardian do
  use Guardian, otp_app: :rocketlivery

  alias Rocketlivery.User
  alias Rocketlivery.Users.Get, as: GetUser

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(%{"sub" => id}) do
    GetUser.by_id(id)
  end
end
