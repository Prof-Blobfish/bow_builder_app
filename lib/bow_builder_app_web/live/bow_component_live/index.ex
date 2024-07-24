defmodule BowBuilderAppWeb.BowComponentLive.Index do
  use BowBuilderAppWeb, :live_view

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.BowComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :bow_components, BowComponents.list_bow_components())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bow component")
    |> assign(:bow_component, BowComponents.get_bow_component!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bow component")
    |> assign(:bow_component, %BowComponent{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bow components")
    |> assign(:bow_component, nil)
  end

  @impl true
  def handle_info({BowBuilderAppWeb.BowComponentLive.FormComponent, {:saved, bow_component}}, socket) do
    {:noreply, stream_insert(socket, :bow_components, bow_component)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bow_component = BowComponents.get_bow_component!(id)
    {:ok, _} = BowComponents.delete_bow_component(bow_component)

    {:noreply, stream_delete(socket, :bow_components, bow_component)}
  end
end
