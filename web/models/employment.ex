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
    |> cast(params, [:user_id, :company_id, :role])
    |> validate_required([:user_id, :company_id, :role])
  end
end
