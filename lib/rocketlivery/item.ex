defmodule Rocketlivery.Item do
  use Ecto.Schema

  import Ecto.Changeset
  # Esta chave deve ser obrigatória quando o padrão da chave primaria é substituído
  # no caso, foi alterado para UUIDv4 [binary_id]
  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields [:category, :description, :price, :photo]
  @item_categories [:food, :drink, :desert]

  # Este [derive] faz uma chamada "automatica" pras views pra toda vez que for necessario renderizar um usuario
  # assim nao temos a necessidade de mapear quais campos queremos mostrar em cada view, respectivo a este modulo
  @derive {Jason.Encoder, only: @required_fields ++ [:id]}

  schema "items" do
    field :category, Ecto.Enum, values: @item_categories
    field :description, :string
    field :price, :decimal
    field :photo, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than: 0)
  end
end
