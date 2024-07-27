defmodule BowBuilderAppWeb.BowComponentLive.Index do
  use BowBuilderAppWeb, :live_view

  import Ecto.Query, warn: false

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.BowComponents.{BowComponent, Component}
  alias BowBuilderApp.Repo

  def list_components_by_type(type) do
    from(c in Component, where: c.type == ^type)
    |> Repo.all()
    |> IO.inspect(label: "Catalogs")
  end

  @impl true
  def mount(params, _session, socket) do
    bow_id = params["bow_id"]
    component_type = params["type"]

    changeset = BowComponents.change_bow_component(%BowComponent{})
    socket =
      socket
      |> assign(changeset: changeset, bow_id: bow_id, type: component_type)
      |> assign(:risers_catalog, list_components_by_type("riser"))

    IO.inspect(socket.assigns.risers_catalog, label: "Risers Catalog")

    {:ok, stream(socket, :bow_components, BowComponents.list_bow_components())}


  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bow Component")
    |> assign(:bow_component, BowComponents.get_bow_component!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bow Component")
    |> assign(:bow_component, %BowComponent{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bow Components")
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
