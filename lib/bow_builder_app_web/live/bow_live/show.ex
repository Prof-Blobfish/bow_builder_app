defmodule BowBuilderAppWeb.BowLive.Show do
  use BowBuilderAppWeb, :live_view

  alias BowBuilderApp.BowComponents
  alias BowBuilderApp.Repo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    bow =
      BowComponents.get_bow!(id)
      |> Repo.preload(:bow_components)

    riser = Enum.find(bow.bow_components, fn component -> component.type == "riser" end)
    limbs = Enum.find(bow.bow_components, fn component -> component.type == "limbs" end)
    stabs = Enum.find(bow.bow_components, fn component -> component.type == "stabs" end)
    sight = Enum.find(bow.bow_components, fn component -> component.type == "sight" end)

    _components_found = [riser, limbs, stabs, sight]

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(bow: bow)
     |> assign(riser: riser)
     |> assign(limbs: limbs)
     |> assign(stabs: stabs)
     |> assign(sight: sight)
     |> IO.inspect()}
  end

  defp page_title(:show), do: "Show Bow"
  defp page_title(:edit), do: "Edit Bow"
end
