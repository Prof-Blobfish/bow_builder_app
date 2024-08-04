defmodule BowBuilderAppWeb.BowOptionLive.Index do
  use BowBuilderAppWeb, :live_view

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.BowOption

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :bow_options, BowComponents.list_bow_options())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bow option")
    |> assign(:bow_option, BowComponents.get_bow_option!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bow option")
    |> assign(:bow_option, %BowOption{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bow options")
    |> assign(:bow_option, nil)
  end

  @impl true
  def handle_info({BowBuilderAppWeb.BowOptionLive.FormComponent, {:saved, bow_option}}, socket) do
    {:noreply, stream_insert(socket, :bow_options, bow_option)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bow_option = BowComponents.get_bow_option!(id)
    {:ok, _} = BowComponents.delete_bow_option(bow_option)

    {:noreply, stream_delete(socket, :bow_options, bow_option)}
  end
end
