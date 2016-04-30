defmodule VuejsOnPhoenix.CommentView do
  use VuejsOnPhoenix.Web, :view

  def render("index.json", %{comment: comment}) do
    %{data: render_many(comment, VuejsOnPhoenix.CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, VuejsOnPhoenix.CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      body: comment.body,
      post_id: comment.post_id}
  end
end
