defmodule Brainhub.UserTest do
  use Brainhub.ModelCase

  alias Brainhub.User

  @valid_attrs %{
    email: "e@mail.com", password: "psword", password_confirmation: "psword",
    first_name: "some content", last_name: "some content"
  }
  @invalid_attrs %{}

  describe "changeset/2" do
    test "with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "with invalid attributes" do
      changeset = User.changeset(%User{}, @invalid_attrs)
      refute changeset.valid?
    end
  end

  describe "current_employment/1" do
  end

  describe "current_company/1" do
  end
end
