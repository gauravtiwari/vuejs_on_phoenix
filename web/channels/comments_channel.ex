defmodule VuejsOnPhoenix.CommentsChannel do
  use VuejsOnPhoenix.Web, :channel

  def join("comments:" <> post_id, _payload, socket) do
    {:ok, "Joined comments:#{post_id}", socket }
  end

  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  def broadcast_comment(comment) do
    VuejsOnPhoenix.Endpoint.broadcast!(
      "comments:#{comment.post_id}",
      "new_comment",
      %{
        body: comment.body,
        post_id: comment.post_id,
        id: comment.id
      }
    )
  end
end
