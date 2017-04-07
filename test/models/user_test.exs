defmodule Brainhub.UserTest do
  use Brainhub.ModelCase

  alias Brainhub.User

  import GoodTimes
  import GoodTimes.Convert
  import GoodTimes.Date

  @valid_attrs %{
    email: "email@example.com",
    password: "password", password_confirmation: "password",
    first_name: "some content", last_name: "some content"
  }
  @invalid_attrs %{}

  setup do
    user = insert :user
    {:ok, a_week_ago} = Calendar.DateTime.from_erl(a_week_ago(), "Etc/UTC")
    {:ok, yesterday} = Calendar.DateTime.from_erl(yesterday() |> from_date, "Etc/UTC")
    today = Calendar.DateTime.now_utc
    {:ok, tomorrow} = Calendar.DateTime.from_erl(tomorrow() |> from_date, "Etc/UTC")

    {:ok, user: user, a_week_ago: a_week_ago, yesterday: yesterday, today: today, tomorrow: tomorrow}
  end

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
    test "when employment is started", %{user: user, yesterday: yesterday} do
      employment = insert :employment, user: user, start_at: yesterday
      current_employment = User.current_employment(user)
      assert current_employment
      assert current_employment.id == employment.id
    end

    test "when employment is not started", %{user: user, tomorrow: tomorrow} do
      _employment = insert :employment, user: user, start_at: tomorrow
      refute User.current_employment(user)
    end

    test "when user is fired", %{user: user, a_week_ago: a_week_ago, yesterday: yesterday} do
      _employment = insert :employment, user: user, start_at: a_week_ago, end_at: yesterday
      refute User.current_employment(user)
    end

    test "when user is not fired yet", %{user: user, a_week_ago: a_week_ago, tomorrow: tomorrow} do
      employment = insert :employment, user: user, start_at: a_week_ago, end_at: tomorrow
      current_employment = User.current_employment(user)
      assert current_employment
      assert current_employment.id == employment.id
    end
  end

  describe "current_company/1" do
    test "when user is hired", %{user: user, a_week_ago: a_week_ago} do
      employment = insert :employment, user: user, start_at: a_week_ago
      current_company = User.current_company(user)
      assert current_company
      assert current_company.id == employment.company.id
    end

    test "when user is not hired yet", %{user: user, tomorrow: tomorrow} do
      _employment = insert :employment, user: user, start_at: tomorrow
      refute User.current_company(user)
    end

    test "when user is fired", %{user: user, a_week_ago: a_week_ago, yesterday: yesterday} do
      _employment = insert :employment, user: user, start_at: a_week_ago, end_at: yesterday
      refute User.current_company(user)
    end
  end
end
