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

  def employer?(%Brainhub.Company{id: company_id}, %Brainhub.User{id: user_id}) do
    employer? company_id, user_id
  end

  def employer?(company_id, user_id) do
    employment = Brainhub.Employment
      |> where(user_id: ^user_id, company_id: ^company_id)
      |> Repo.one
    !!employment
  end

  def management?(%Brainhub.Company{id: company_id}, %Brainhub.User{id: user_id}) do
    management? company_id, user_id
  end

  def management?(company_id, user_id) do
    role = Brainhub.Employment
      |> where(user_id: ^user_id, company_id: ^company_id)
      |> select([e], e.role)
      |> Repo.one
    Enum.member? ["CEO", "CTO", "project manager"], role
  end

  def employee_ids(%Brainhub.Company{id: company_id}), do: employee_ids company_id

  def employee_ids(company_id) do
    Brainhub.Employment
    |> where(company_id: ^company_id)
    |> select([e], e.user_id)
    |> Repo.all
  end

  def employees(%Brainhub.Company{id: company_id}), do: employees company_id

  def employees(company_id) do
    Brainhub.User
    |> where([u], u.id in ^employee_ids(company_id))
    |> Repo.all
  end
end
