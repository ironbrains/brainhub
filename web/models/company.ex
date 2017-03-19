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
end
