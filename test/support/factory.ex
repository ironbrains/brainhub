defmodule Brainhub.Factory do
  use ExMachina.Ecto, repo: Brainhub.Repo

  def user_factory do
    %Brainhub.User{
      first_name: "Jane",
      last_name: "Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      encrypted_password: "encrypted_password",
    }
  end

  def project_factory do
    %Brainhub.Project{
      name: "Project",
      description: "description",
      creator: build(:user),
      company: build(:company)
    }
  end

  def company_factory do
    %Brainhub.Company{
      name: "Company name",
      web_site: "company_name.com"
    }
  end

  def employment_factory do
    %Brainhub.Employment{
      user: build(:user),
      company: build(:company),
      role: "CEO"
    }
  end
end