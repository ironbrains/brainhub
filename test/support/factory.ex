defmodule BrainhubWeb.Factory do
  use ExMachina.Ecto, repo: Brainhub.Repo

  def user_factory do
    %BrainhubWeb.User{
      first_name: "Jane",
      last_name: "Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      encrypted_password: "encrypted_password",
    }
  end

  def project_factory do
    %BrainhubWeb.Project{
      name: "Project",
      description: "description",
      creator: build(:user),
      company: build(:company)
    }
  end

  def company_factory do
    %BrainhubWeb.Company{
      name: "Company name",
      web_site: "company_name.com"
    }
  end

  def employment_factory do
    %BrainhubWeb.Employment{
      user: build(:user),
      company: build(:company),
      role: "CEO",
      start_at: Calendar.DateTime.now_utc
    }
  end

  def team_factory do
    %BrainhubWeb.Team{
      name: "Team name",
      project: build(:project)
    }
  end

  def team_membership_factory do
    %BrainhubWeb.TeamMembership{
      user: build(:user),
      team: build(:team)
    }
  end

  def time_entry_factory do
    %BrainhubWeb.TimeEntry{
      start_at: Calendar.DateTime.now_utc,
      duration: 3600,
      user: build(:user),
      project: build(:project)
    }
  end
end
