defmodule Brainhub.EmploymentView do
  use Brainhub.Web, :view

  def render("employment.json", %{employment: employment}) do
    employment = Brainhub.Repo.preload(employment, :company)
    %{id: employment.id, company: employment.company.name, role: employment.role}
  end
end
