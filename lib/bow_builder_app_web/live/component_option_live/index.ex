defmodule BowBuilderAppWeb.ComponentOptionLive.Index do
  use BowBuilderAppWeb, :live_view

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.ComponentOption

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :component_options, BowComponents.list_component_options())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Component option")
    |> assign(:component_option, BowComponents.get_component_option!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Component option")
    |> assign(:component_option, %ComponentOption{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Component options")
    |> assign(:component_option, nil)
  end

  @impl true
  def handle_info({BowBuilderAppWeb.ComponentOptionLive.FormComponent, {:saved, component_option}}, socket) do
    {:noreply, stream_insert(socket, :component_options, component_option)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    component_option = BowComponents.get_component_option!(id)
    {:ok, _} = BowComponents.delete_component_option(component_option)

    {:noreply, stream_delete(socket, :component_options, component_option)}
  end
end
