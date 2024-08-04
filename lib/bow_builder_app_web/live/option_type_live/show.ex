defmodule BowBuilderAppWeb.OptionTypeLive.Show do
  use BowBuilderAppWeb, :live_view

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.Component
  alias BowBuilderApp.Repo

  @impl true
  def mount(params, _session, socket) do
    component = Repo.get(Component, params["component_id"])

    socket =
      socket
      |> assign(:component, component)

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:option_type, BowComponents.get_option_type!(id))}
  end

  defp page_title(:show), do: "Show Option type"
  defp page_title(:edit), do: "Edit Option type"
end
