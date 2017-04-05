defmodule Brainhub.EmploymentTest do
  use Brainhub.ModelCase

  alias Brainhub.Employment

  @valid_attrs %{role: "some content", user_id: 1, company_id: 1, start_at: Calendar.DateTime.now_utc}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Employment.changeset(%Employment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Employment.changeset(%Employment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
