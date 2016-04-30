defmodule VuejsOnPhoenix.PageController do
  use VuejsOnPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
