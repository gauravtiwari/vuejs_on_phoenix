defmodule VuejsOnPhoenix.CommentController do
  use VuejsOnPhoenix.Web, :controller
  alias VuejsOnPhoenix.Comment

  plug :scrub_params, "comment" when action in [:create, :update]

  def index(conn, _params) do
    comment = Repo.all(Comment)
    render(conn, "index.json", comment: comment)
  end

  def create(conn, %{"comment" => comment_params}) do
    changeset = Comment.changeset(%Comment{}, comment_params)

    case Repo.insert(changeset) do
      {:ok, comment} ->
        VuejsOnPhoenix.CommentsChannel.broadcast_comment(comment)
        conn
        |> put_status(:created)
        |> render("comment.json", comment: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(VuejsOnPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Repo.get!(Comment, id)
    changeset = Comment.changeset(comment, comment_params)

    case Repo.update(changeset) do
      {:ok, comment} ->
        render(conn, "show.json", comment: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(VuejsOnPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    send_resp(conn, :no_content, "")
  end
end
