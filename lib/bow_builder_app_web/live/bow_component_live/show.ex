defmodule BowBuilderAppWeb.BowComponentLive.Show do
  use BowBuilderAppWeb, :live_view

  import Ecto.Query, warn: false

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.Bow
  alias BowBuilderApp.BowComponents.Component
  alias BowBuilderApp.Repo

  def list_components_by_type(type) do
    from(c in Component, where: c.type == ^type)
    |> Repo.all()
  end

  @impl true
  def mount(params, _session, socket) do
    bow = Repo.get(Bow, params["bow_id"])

    socket =
      socket
      |> assign(:bow, bow)
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    bow_component =
      BowComponents.get_bow_component!(id)
      |> Repo.preload(:bow)
      |> Repo.preload(:component)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bow_component, bow_component)
     |> assign(:catalog, list_components_by_type(bow_component.type))}
  end

  defp page_title(:show), do: "Show Bow component"
  defp page_title(:edit), do: "Edit Bow component"
end
