defmodule BowBuilderAppWeb.BowOptionLive.Index do
  use BowBuilderAppWeb, :live_view

  import Ecto.Query, warn: false

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.{Bow, BowOption, BowComponent, Component, OptionType}
  alias BowBuilderApp.Repo

  def list_option_types_by_component_id(component_id) do
    Repo.all(from ot in OptionType, where: ot.component_id == ^component_id, preload: [:option_values])
  end

  @impl true
  def mount(params, _session, socket) do
    bow = Repo.get(Bow, params["bow_id"])
    bow_component = Repo.get(BowComponent, params["bow_component_id"])
    component = Repo.get(Component, bow_component.component_id)
    option_types = list_option_types_by_component_id(component.id)
    bow_options = BowComponents.list_bow_options()
    |> Repo.preload(:option_type)
    |> Repo.preload(:option_value)

    socket =
      socket
      |> assign(
        bow: bow,
        bow_component: bow_component,
        component: component,
        option_types: option_types
        )

    {:ok, stream(socket, :bow_options, bow_options)}
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
