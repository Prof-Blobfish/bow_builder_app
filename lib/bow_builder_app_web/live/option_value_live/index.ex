defmodule BowBuilderAppWeb.OptionValueLive.Index do
  use BowBuilderAppWeb, :live_view

  import Ecto.Query, warn: false

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.Component
  alias BowBuilderApp.BowComponents.OptionType
  alias BowBuilderApp.BowComponents.OptionValue
  alias BowBuilderApp.Repo

  @impl true
  def mount(params, _session, socket) do
    IO.inspect(params)
    component = Repo.get(Component, params["component_id"])
    option_type = Repo.get(OptionType, params["option_type_id"])

    socket =
      socket
      |> assign(
        component: component,
        option_type: option_type
        )

    {:ok, stream(socket, :option_values, BowComponents.list_option_values())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Option value")
    |> assign(:option_value, BowComponents.get_option_value!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Option value")
    |> assign(:option_value, %OptionValue{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Option values")
    |> assign(:option_value, nil)
  end

  @impl true
  def handle_info({BowBuilderAppWeb.OptionValueLive.FormComponent, {:saved, option_value}}, socket) do
    {:noreply, stream_insert(socket, :option_values, option_value)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    option_value = BowComponents.get_option_value!(id)
    {:ok, _} = BowComponents.delete_option_value(option_value)

    {:noreply, stream_delete(socket, :option_values, option_value)}
  end
end
