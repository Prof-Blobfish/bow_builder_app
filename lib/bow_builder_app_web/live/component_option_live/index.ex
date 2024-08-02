defmodule BowBuilderAppWeb.OptionTypeLive.Index do
  use BowBuilderAppWeb, :live_view

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.OptionType

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :option_types, BowComponents.list_option_types())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Component option")
    |> assign(:option_type, BowComponents.get_option_type!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Component option")
    |> assign(:option_type, %OptionType{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Component options")
    |> assign(:option_type, nil)
  end

  @impl true
  def handle_info(
        {BowBuilderAppWeb.OptionTypeLive.FormComponent, {:saved, option_type}},
        socket
      ) do
    {:noreply, stream_insert(socket, :option_types, option_type)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    option_type = BowComponents.get_option_type!(id)
    {:ok, _} = BowComponents.delete_option_type(option_type)

    {:noreply, stream_delete(socket, :option_types, option_type)}
  end
end
