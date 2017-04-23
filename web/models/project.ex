defmodule Brainhub.Project do
  use Brainhub.Web, :model

  alias Brainhub.Repo

  schema "projects" do
    field :name, :string
    field :description, :string

    belongs_to :creator, Brainhub.User
    belongs_to :company, Brainhub.Company

    has_many :teams, Brainhub.Team

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :company_id])
    |> validate_required([:name, :description])
  end

  def modifiable?(project, user) do
    project.creator_id == user.id
  end

  def available_ids_for(%Brainhub.User{id: user_id}), do: available_ids_for user_id

  def available_ids_for(user_id) do
    Brainhub.Team
    |> where([t], t.id in ^Brainhub.Team.ids_for(user_id))
    |> select([t], t.project_id)
    |> Repo.all
  end

  def available_for(%Brainhub.User{id: user_id}), do: available_for user_id

  def available_for(user_id) do
    Brainhub.Project
    |> where([p], p.id in ^available_ids_for(user_id))
    |> Repo.all
  end
end
