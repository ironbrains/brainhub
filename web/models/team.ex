defmodule Brainhub.Team do
  use Brainhub.Web, :model

  schema "teams" do
    field :name, :string
    field :user_id, :integer, virtual: true

    belongs_to :project, Brainhub.Project

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :project_id, :user_id])
    |> validate_required([:name, :project_id, :user_id])
    |> validate_company
  end

  defp validate_company(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{project_id: project_id, user_id: user_id}} ->
        project = Brainhub.Repo.get(Brainhub.Project, project_id)
        query = from e in Brainhub.Employment,
          where: e.user_id == ^user_id and e.company_id == ^project.company_id,
          select: e.id
        case Brainhub.Repo.one(query) do
          nil -> add_error(changeset, :user_id, "can't create team for this project")
          _ -> changeset
        end
      _ ->
        changeset
    end
  end
end
