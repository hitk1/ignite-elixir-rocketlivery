defmodule Rocketlivery.Order do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rocketlivery.{User, Item}
  # Esta chave deve ser obrigatória quando o padrão da chave primaria é substituído
  # no caso, foi alterado para UUIDv4 [binary_id]
  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields [:address, :comments, :payment_method, :user_id]
  @payment_methods [:money, :credit_card, :debit_card]

  # Este [derive] faz uma chamada "automatica" pras views pra toda vez que for necessario renderizar um usuario
  # assim nao temos a necessidade de mapear quais campos queremos mostrar em cada view, respectivo a este modulo
  @derive {Jason.Encoder, only: @required_fields ++ [:id]}

  schema "items" do
    field :address, :string
    field :comments, :string
    field :payment_method, Ecto.Enum, values: @payment_methods

    many_to_many :items, Item, join_through: "order_items"
    belongs_to :user, User

    timestamps()
  end

  def changeset(params \\ %__MODULE__{}, params, items) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> put_assoc(:items, items)
    |> validate_length(:address, min: 10)
    |> validate_length(:comments, min: 6)
  end
end
