defmodule RocketliveryWeb.UsersControllerTest do
  use RocketliveryWeb.ConnCase, async: true

  import Rocketlivery.Factory

  alias RocketliveryWeb.Auth.Guardian

  describe "create/2" do
    # Para testar um controller, cada test recebe a conexão também para realizar os testes adequadamente
    test "when all params are valid, creates the user", %{conn: conn} do
      params = %{
        "age" => "24",
        "address" => "Rua teste do tste, 34",
        "cep" => "12345688",
        "cpf" => "12345678900",
        "email" => "test@mail.com",
        "password" => "123123",
        "name" => "Testing app"
      }

      # Dessa forma é possível fazer uma requisição para o endpoint de criação de usuarios
      # [users_path] é uma função que retorna todas as actions do respectivo dominio (usuarios)
      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created successfully!",
               "user" => %{
                 "id" => _id,
                 "name" => "Testing app"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{
        "password" => "123123",
        "name" => "Testing app"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert response == %{
               "message" => %{
                 "address" => ["can't be blank"],
                 "age" => ["can't be blank"],
                 "cep" => ["can't be blank"],
                 "cpf" => ["can't be blank"],
                 "email" => ["can't be blank"]
               }
             }
    end
  end

  describe "delete/2" do
    # Também é possivel acessar a conexão através do setup
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when there is a user with the giver id, deletes the user", %{conn: conn} do
      hard_coded_id = "34998af8-9c2d-4961-a0d7-51666758cf2e"
      insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, hard_coded_id))
        |> response(:ok)

      assert "{\"message\":\"User deleted successfully!\"}" == response
    end
  end
end
