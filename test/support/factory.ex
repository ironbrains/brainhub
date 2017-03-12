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
        creator: build(:user)
      }
    end
end