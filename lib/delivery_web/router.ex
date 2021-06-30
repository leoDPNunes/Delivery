defmodule DeliveryWeb.Router do
  use DeliveryWeb, :router

  alias DeliveryWeb.Plugs.UUIDChecker

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
  end

  pipeline :auth do
    plug DeliveryWeb.Auth.Pipeline
  end

  scope "/api", DeliveryWeb do
    pipe_through [:api, :auth]

    resources "/users", UsersController, except: [:new, :edit, :create]

    resources "/items", ItemsController, except: [:new, :edit]

    post "/orders", OrdersController, :create
  end

  scope "/api", DeliveryWeb do
    pipe_through :api

    get "/", WelcomeController, :index

    post "/users/", UsersController, :create
    post "/users/signin", UsersController, :sign_in
  end

  scope "/api" do
    pipe_through :api

    forward("/graphql", Absinthe.Plug, schema: DeliveryWeb.Schema)
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: DeliveryWeb.Schema
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
      live_dashboard "/dashboard", metrics: DeliveryWeb.Telemetry
    end
  end
end
