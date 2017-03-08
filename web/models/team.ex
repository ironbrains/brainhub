defmodule Brainhub.Team do
  use Brainhub.Web, :model

  schema "teams" do
    field :name, :string

    belongs_to :project, Brainhub.Project

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
