defmodule Brainhub.Company do
  use Brainhub.Web, :model

  alias Brainhub.Repo

  schema "companies" do
    field :name, :string
    field :web_site, :string

    has_many :projects, Brainhub.Project
    has_many :employments, Brainhub.Employment

    has_many :employees, through: [:employments, :users]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :web_site])
    |> validate_required([:name, :web_site])
  end

  def employer?(company, user) when is_map(company) and is_map(user) do
    employer? company.id, user.id
  end

  def employer?(company_id, user_id) do
    employment = Brainhub.Employment
      |> where(user_id: ^user_id, company_id: ^company_id)
      |> Repo.one
    !!employment
  end

  def management?(company, user) when is_map(company) and is_map(user) do
    management? company.id, user.id
  end

  def management?(company_id, user_id) do
    role = Brainhub.Employment
      |> where(user_id: ^user_id, company_id: ^company_id)
      |> select([e], e.role)
      |> Repo.one
    Enum.member? ["CEO", "CTO", "project manager"], role
  end

  def employee_ids(company) when is_map(company), do: employee_ids company.id

  def employee_ids(company_id) do
    Brainhub.Employment
    |> where(company_id: ^company_id)
    |> select([e], e.user_id)
    |> Repo.all
  end

  def employees(company) when is_map(company), do: employees company.id

  def employees(company_id) do
    Brainhub.User
    |> where([u], u.id in ^employee_ids(company_id))
    |> Repo.all
  end
end
