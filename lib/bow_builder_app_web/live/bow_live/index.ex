defmodule BowBuilderAppWeb.BowLive.Index do
  use BowBuilderAppWeb, :live_view

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.Bow

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :bows, BowComponents.list_bows())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bow")
    |> assign(:bow, BowComponents.get_bow!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bow")
    |> assign(:bow, %Bow{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bows")
    |> assign(:bow, nil)
  end

  @impl true
  def handle_info({BowBuilderAppWeb.BowLive.FormComponent, {:saved, bow}}, socket) do
    {:noreply, stream_insert(socket, :bows, bow)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bow = BowComponents.get_bow!(id)
    {:ok, _} = BowComponents.delete_bow(bow)

    {:noreply, stream_delete(socket, :bows, bow)}
  end
end
