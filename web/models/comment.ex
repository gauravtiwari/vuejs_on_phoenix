defmodule VuejsOnPhoenix.Comment do
  use VuejsOnPhoenix.Web, :model

  schema "comment" do
    field :body, :string
    belongs_to :post, VuejsOnPhoenix.Post

    timestamps
  end

  @required_fields ~w(body post_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
