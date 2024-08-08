defmodule BowBuilderAppWeb.BowOptionLive.Show do
  use BowBuilderAppWeb, :live_view

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.{Bow, BowComponent}
  alias BowBuilderApp.Repo

  @impl true
  def mount(params, _session, socket) do
    bow = Repo.get(Bow, params["bow_id"])
    bow_component = Repo.get(BowComponent, params["bow_component_id"])

    socket =
      socket
      |> assign(:bow, bow)
      |> assign(:bow_component, bow_component)

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bow_option, BowComponents.get_bow_option!(id))}
  end

  defp page_title(:show), do: "Show Bow option"
  defp page_title(:edit), do: "Edit Bow option"
end
