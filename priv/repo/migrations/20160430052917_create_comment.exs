defmodule VuejsOnPhoenix.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comment) do
      add :body, :string
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps
    end
    create index(:comment, [:post_id])

  end
end
