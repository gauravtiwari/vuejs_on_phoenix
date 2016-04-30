defmodule VuejsOnPhoenix.Router do
  use VuejsOnPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VuejsOnPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PostController, :index
    resources "/posts", PostController do
      resources "/comment", CommentController, except: [:new, :edit]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", VuejsOnPhoenix do
  #   pipe_through :api
  # end
end
