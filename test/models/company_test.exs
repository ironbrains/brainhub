defmodule Brainhub.CompanyTest do
  use Brainhub.ModelCase

  alias Brainhub.Company

  @valid_attrs %{name: "some content", web_site: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Company.changeset(%Company{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Company.changeset(%Company{}, @invalid_attrs)
    refute changeset.valid?
  end
end
