defmodule Brainhub.CompanyTest do
  use Brainhub.ModelCase

  alias Brainhub.Company

  @valid_attrs %{name: "some content", web_site: "some content"}
  @invalid_attrs %{}

  describe "changeset/2" do
    test "with valid attributes" do
      changeset = Company.changeset(%Company{}, @valid_attrs)
      assert changeset.valid?
    end

    test "with invalid attributes" do
      changeset = Company.changeset(%Company{}, @invalid_attrs)
      refute changeset.valid?
    end
  end

  describe "employer?/2" do
  end

  describe "management?/2" do
  end

  describe "employee_ids/1" do
  end

  describe "employees/1" do
  end
end
