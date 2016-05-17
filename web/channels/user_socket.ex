defmodule VuejsOnPhoenix.UserSocket do
  use Phoenix.Socket

  channel "comments:*", VuejsOnPhoenix.CommentsChannel

  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  def connect(params, socket) do
    {:ok, assign(socket, :user_id, params["user_id"])}
  end

  def id(_socket), do: nil
end
