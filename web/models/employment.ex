defmodule Brainhub.Employment do
  use Brainhub.Web, :model

  schema "employments" do
    field :role, :string

    belongs_to :user, Brainhub.User
    belongs_to :company, Brainhub.Company

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:role])
    |> validate_required([:role])
  end
end
