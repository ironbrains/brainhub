defmodule BrainhubWeb.CompanyTest do
  use BrainhubWeb.ModelCase

  alias BrainhubWeb.Company

  @valid_attrs %{name: "some content", web_site: "some content"}
  @invalid_attrs %{}

  setup do
    first_user = insert :user
    second_user = insert :user
    third_user = insert :user

    company = insert :company
    insert :employment, user: first_user, company: company
    insert :employment, user: second_user, company: company
    {:ok, first_user: first_user, second_user: second_user, third_user: third_user, company: company}
  end

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
    test "with integer includes all company employees", context do
      employees = Company.employees context[:company].id
      assert Enum.member?(employees, context[:first_user])
      assert Enum.member?(employees, context[:second_user])
    end

    test "with integer does not include no employees", %{third_user: third_user, company: company} do
      employees = Company.employees company.id
      refute Enum.member?(employees, third_user)
    end

    test "with struct includes all company employees", context do
      employees = Company.employees context[:company]
      assert Enum.member?(employees, context[:first_user])
      assert Enum.member?(employees, context[:second_user])
    end

    test "with struct does not include no employees", %{third_user: third_user, company: company} do
      employees = Company.employees company
      refute Enum.member?(employees, third_user)
    end
  end
end
