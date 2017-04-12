defmodule Brainhub.Employment do
  use Brainhub.Web, :model

  schema "employments" do
    field :role,     :string
    field :start_at, :utc_datetime
    field :end_at,   :utc_datetime

    belongs_to :user, Brainhub.User
    belongs_to :company, Brainhub.Company

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :company_id, :role, :start_at, :end_at])
    |> validate_required([:user_id, :company_id, :role, :start_at ])
  end
end
