defmodule BrainhubWeb.EmploymentView do
  use Brainhub.Web, :view

  def render("employment.json", %{employment: employment}) do
    employment = Brainhub.Repo.preload(employment, :company)
    %{
      id: employment.id,
      company: employment.company.name,
      role: employment.role,
      started_at: employment.start_at |> Calendar.Date.Format.iso8601()
    }
  end
end
