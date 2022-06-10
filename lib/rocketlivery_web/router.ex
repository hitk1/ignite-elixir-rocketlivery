defmodule RocketliveryWeb.Router do
  use RocketliveryWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RocketliveryWeb do
    pipe_through :api

    get "/", WelcomeController, :index

    # Quando há a necessidade de implemetar um crud de um dominio de entidade, no caso usuario
    # basta utilizar o metodo [resources] que ele cria todos os endpoints com os respectivos metodos
    # automaticamente

    # neste caso [new, edit] são endpoint adicionais, fora os comuns
    resources "/users", UsersController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: RocketliveryWeb.Telemetry
    end
  end
end
