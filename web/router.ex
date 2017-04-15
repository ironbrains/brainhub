defmodule Brainhub.Router do
  use Brainhub.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Brainhub do
    pipe_through :api

    scope "/v1" do
      post "/registrations", RegistrationController, :create

      post   "/sessions", SessionController, :create
      delete "/sessions", SessionController, :delete

      resources "/projects", ProjectController, except: [:new]
      resources "/teams",    TeamController,    except: [:new, :edit] do
        resources "/memberships", MembershipController, only: [:create, :delete]
      end
      resources "/users",    UserController,    except: [:new, :edit]
    end
  end

  scope "/", Brainhub do
      pipe_through :browser # Use the default browser stack

      get "/*path", PageController, :index
    end
end
