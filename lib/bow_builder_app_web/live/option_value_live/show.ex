defmodule BowBuilderAppWeb.OptionValueLive.Show do
  use BowBuilderAppWeb, :live_view

  import Ecto.Query, warn: false

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.Component
  alias BowBuilderApp.BowComponents.OptionType
  alias BowBuilderApp.Repo

  @impl true
  def mount(params, _session, socket) do
    component = Repo.get(Component, params["component_id"])
    option_type = Repo.get(OptionType, params["option_type_id"])

    socket =
      socket
      |> assign(
        component: component,
        option_type: option_type
        )

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:option_value, BowComponents.get_option_value!(id))}
  end

  defp page_title(:show), do: "Show Option value"
  defp page_title(:edit), do: "Edit Option value"
end
