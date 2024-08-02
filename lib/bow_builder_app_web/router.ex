defmodule BowBuilderAppWeb.Router do
  use BowBuilderAppWeb, :router

  import BowBuilderAppWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BowBuilderAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BowBuilderAppWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/bows", BowLive.Index, :index
    live "/bows/new", BowLive.Index, :new
    live "/bows/:id/edit", BowLive.Index, :edit

    live "/bows/:id", BowLive.Show, :show
    live "/bows/:id/show/edit", BowLive.Show, :edit

    live "/components", ComponentLive.Index, :index
    live "/components/new", ComponentLive.Index, :new
    live "/components/:id/edit", ComponentLive.Index, :edit

    live "/components/:id", ComponentLive.Show, :show
    live "/components/:id/show/edit", ComponentLive.Show, :edit

    live "/option_types", OptionTypeLive.Index, :index
    live "/option_types/new", OptionTypeLive.Index, :new
    live "/option_types/:id/edit", OptionTypeLive.Index, :edit

    live "/option_types/:id", OptionTypeLive.Show, :show
    live "/option_types/:id/show/edit", OptionTypeLive.Show, :edit

    live "/bows/:bow_id/bow_components", BowComponentLive.Index, :index
    live "/bows/:bow_id/bow_components/new", BowComponentLive.Index, :new
    live "/bows/:bow_id/bow_components/:id/edit", BowComponentLive.Index, :edit

    live "/bows/:bow_id/bow_components/:id", BowComponentLive.Show, :show
    live "/bows/:bow_id/bow_components/:id/show/edit", BowComponentLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", BowBuilderAppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:bow_builder_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BowBuilderAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", BowBuilderAppWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{BowBuilderAppWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", BowBuilderAppWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{BowBuilderAppWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", BowBuilderAppWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{BowBuilderAppWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
