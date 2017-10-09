defmodule BrainhubWeb.Company do
  use Brainhub.Web, :model

  alias Brainhub.Repo

  schema "companies" do
    field :name, :string
    field :web_site, :string

    has_many :projects, BrainhubWeb.Project
    has_many :employments, BrainhubWeb.Employment

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

  def employer?(%BrainhubWeb.Company{id: company_id}, %BrainhubWeb.User{id: user_id}) do
    employer? company_id, user_id
  end

  def employer?(company_id, user_id) do
    employment = BrainhubWeb.Employment
      |> where(user_id: ^user_id, company_id: ^company_id)
      |> Repo.one
    !!employment
  end

  def management?(%BrainhubWeb.Company{id: company_id}, %BrainhubWeb.User{id: user_id}) do
    management? company_id, user_id
  end

  def management?(company_id, user_id) do
    role = BrainhubWeb.Employment
      |> where(user_id: ^user_id, company_id: ^company_id)
      |> select([e], e.role)
      |> Repo.one
    Enum.member? ["CEO", "CTO", "project manager"], role
  end

  def employee_ids(%BrainhubWeb.Company{id: company_id}), do: employee_ids company_id

  def employee_ids(company_id) do
    BrainhubWeb.Employment
    |> where(company_id: ^company_id)
    |> select([e], e.user_id)
    |> Repo.all
  end

  def employees(%BrainhubWeb.Company{id: company_id}), do: employees company_id

  def employees(company_id) do
    BrainhubWeb.User
    |> where([u], u.id in ^employee_ids(company_id))
    |> Repo.all
  end
end
