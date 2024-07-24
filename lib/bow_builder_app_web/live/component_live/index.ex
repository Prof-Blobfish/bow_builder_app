defmodule BowBuilderAppWeb.ComponentLive.Index do
  use BowBuilderAppWeb, :live_view

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.Component

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :components, BowComponents.list_components())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Component")
    |> assign(:component, BowComponents.get_component!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Component")
    |> assign(:component, %Component{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Components")
    |> assign(:component, nil)
  end

  @impl true
  def handle_info({BowBuilderAppWeb.ComponentLive.FormComponent, {:saved, component}}, socket) do
    {:noreply, stream_insert(socket, :components, component)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    component = BowComponents.get_component!(id)
    {:ok, _} = BowComponents.delete_component(component)

    {:noreply, stream_delete(socket, :components, component)}
  end
end
