defmodule Brainhub.TeamMembership do
  use Brainhub.Web, :model

  schema "team_memberships" do
    field :initiator_id, :integer, virtual: true

    belongs_to :user, Brainhub.User
    belongs_to :team, Brainhub.Team

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :team_id, :initiator_id])
    |> validate_required([:initiator_id])
    |> assoc_constraint(:user)
    |> assoc_constraint(:team)
    |> validate_users
  end

  defp validate_users(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{initiator_id: initiator_id, user_id: user_id, team_id: team_id}} ->
        team = Brainhub.Repo.get(Brainhub.Team, team_id) |> Brainhub.Repo.preload(:company)

        changeset
        |> validate_initiator(team.company.id, initiator_id)
        |> validate_member(team.company.id, user_id)
      _ ->
        changeset
    end
  end

  defp validate_initiator(changeset, company_id, initiator_id) do
    if Brainhub.Company.management?(company_id, initiator_id) do
      changeset
    else
      add_error(changeset, :initiator_id, "can't add member for this team")
    end
  end

  defp validate_member(changeset, company_id, user_id) do
    if Brainhub.Company.employer?(company_id, user_id) do
      changeset
    else
      add_error(changeset, :user_id, "can't be added to this team")
    end
  end
end
