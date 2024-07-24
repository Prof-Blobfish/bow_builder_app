defmodule BowBuilderAppWeb.BowComponentLive.Show do
  use BowBuilderAppWeb, :live_view

  alias BowBuilderApp.BowComponents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bow_component, BowComponents.get_bow_component!(id))}
  end

  defp page_title(:show), do: "Show Bow component"
  defp page_title(:edit), do: "Edit Bow component"
end
