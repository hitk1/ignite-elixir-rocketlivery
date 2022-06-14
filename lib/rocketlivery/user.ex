defmodule Rocketlivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  # Esta chave deve ser obrigatória quando o padrão da chave primaria é substituído
  # no caso, foi alterado para UUIDv4 [binary_id]
  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields [:address, :age, :cep, :cpf, :email, :password, :name]

  # Este [derive] faz uma chamada "automatica" pras views pra toda vez que for necessario renderizar um usuario
  # assim nao temos a necessidade de mapear quais campos queremos mostrar em cada view, respectivo a este modulo
  @derive {Jason.Encoder, only: [:id, :age, :cpf, :address, :email]}

  schema "users" do
    field :address, :string
    field :age, :integer
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> changes(params)
  end

  # Adiciona um struct com valor default para aproveitar a lógica para criação e atualização
  def changeset(struct, params) do
    struct
    |> cast(params, @required_fields)
    |> changes(params)
  end

  defp changes(struct, params) do
    struct
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> put_password_hash
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(
      changeset,
      Pbkdf2.add_hash(password)
    )
  end

  # Caso não houver um match na função valida (acima), o changeset invalido deve ser retornada para fins de validação pra função que chamou
  defp put_password_hash(changeset), do: changeset
end
