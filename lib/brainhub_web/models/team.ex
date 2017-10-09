defmodule BrainhubWeb.Team do
  use Brainhub.Web, :model

  alias Brainhub.Repo

  schema "teams" do
    field :name, :string
    field :user_id, :integer, virtual: true

    belongs_to :project, BrainhubWeb.Project

    has_one :company, through: [:project, :company]

    has_many :team_memberships, BrainhubWeb.TeamMembership
    has_many :members, through: [:team_memberships, :user]

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

  def ids_for(%BrainhubWeb.User{id: user_id}), do: ids_for user_id

  def ids_for(user_id) do
    BrainhubWeb.TeamMembership
    |> where(user_id: ^user_id)
    |> select([m], m.team_id)
    |> Repo.all
  end

  defp validate_company(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{project_id: project_id, user_id: user_id}} ->
        project = Repo.get(BrainhubWeb.Project, project_id)

        if BrainhubWeb.Company.management?(project.company_id, user_id) do
          changeset
        else
          add_error(changeset, :user_id, "can't create team for this project")
        end
      _ ->
        changeset
    end
  end
end
