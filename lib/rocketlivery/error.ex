defmodule Rocketlivery.Error do
  @keys [:status, :reason]
  @enforce_keys @keys

  defstruct @keys

  def build(status, reason) do
    %__MODULE__{
      status: status,
      reason: reason
    }
  end

  def build_user_not_found, do: build(:not_found, "User not found!")
  def build_id_format_error, do: build(:bad_request, "Invalid id format")
end
