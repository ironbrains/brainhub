defmodule Brainhub.User do
  use Brainhub.Web, :model

  alias Brainhub.Repo

  @derive {Poison.Encoder, only: [:id, :first_name, :last_name, :email]}

  schema "users" do
    field :first_name,         :string
    field :last_name,          :string
    field :email,              :string
    field :encrypted_password, :string
    field :password,           :string, virtual: true

    has_many :created_projects, Brainhub.Project, foreign_key: :creator_id
    has_many :employments, Brainhub.Employment
    has_many :team_memberships, Brainhub.TeamMembership
    has_many :teams, through: [:team_memberships, :team]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :email, :password])
    |> validate_required([:first_name, :last_name, :email])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:email, message: "Email already taken")
    |> generate_encrypted_password
  end

  def current_employment(user) do
    now = Calendar.DateTime.now_utc
    assoc(user, :employments)
      |> where([e], e.start_at <= ^now and (is_nil(e.end_at) or e.end_at >= ^now))
      |> Repo.one
  end

  def current_company(user) do
    case current_employment(user) do
      nil -> nil
      employment ->
        employment = Repo.preload(employment, :company)
        employment.company
    end
  end

  def generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(current_changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        current_changeset
    end
  end
end
