defmodule Brainhub.Company do
  use Brainhub.Web, :model

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

  def employer?(company_id, user_id) do
    query = from e in Brainhub.Employment,
      where: e.user_id == ^user_id and e.company_id == ^company_id,
      select: e.id
    !!Brainhub.Repo.one(query)
  end
end
