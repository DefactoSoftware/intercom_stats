defmodule IntercomStatsWeb.Router do
  use IntercomStatsWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  pipeline :graphql do
    plug Plug.Parsers,
      parsers: [:urlencoded, :multipart, :json],
      pass: ["*/*"],
      json_decoder: Poison
    plug :fetch_session
    plug Coherence.Authentication.Session
    plug IntercomStatsWeb.Context
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/", IntercomStatsWeb do
    pipe_through :browser
  end

  scope "/", IntercomStatsWeb do
    pipe_through :protected

    get "/", PageController, :index
    get "/get_from_api", PageController, :get_from_api

    get "/conversations/first_response", ConversationsController, :first_response
    get "/conversations/closing_time", ConversationsController, :closing_time
  end

  scope "/" do
    pipe_through :graphql

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: IntercomStatsWeb.Schema,
      interface: :simple,
      socket: IntercomStatsWeb.UserSocket

    forward "/", Absinthe.Plug,
      schema: IntercomStatsWeb.Schema
  end
end
