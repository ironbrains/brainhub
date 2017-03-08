defmodule Brainhub.Project do
  use Brainhub.Web, :model

  schema "projects" do
    field :name, :string
    field :description, :string

    belongs_to :creator, Brainhub.User

    has_many :teams, Brainhub.Team

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description])
  end
end
