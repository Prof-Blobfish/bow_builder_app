defmodule BowBuilderAppWeb.BowComponentLive.FormComponent do
  use BowBuilderAppWeb, :live_component

  alias BowBuilderApp.BowComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage bow_component records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bow_component-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={@form[:component_id]}
          type="select"
          label="Part Model:"
          options={@components}
          prompt="Choose a model"
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Bow Component</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bow_component: bow_component} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:components, Enum.map(assigns.catalog, &{&1.name, &1.id}))
     |> assign_new(:form, fn ->
       to_form(BowComponents.change_bow_component(bow_component))
     end)}
  end

  @impl true
  def handle_event("validate", %{"bow_component" => bow_component_params}, socket) do
    changeset =
      BowComponents.change_bow_component(socket.assigns.bow_component, bow_component_params)

    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"bow_component" => bow_component_params}, socket) do
    save_bow_component(socket, socket.assigns.action, bow_component_params)
  end

  defp save_bow_component(socket, :edit, bow_component_params) do
    case BowComponents.update_bow_component(socket.assigns.bow_component, bow_component_params) do
      {:ok, bow_component} ->
        notify_parent({:saved, bow_component})

        {:noreply,
         socket
         |> put_flash(:info, "Bow component updated successfully")
         |> push_navigate(to: "/bows/#{socket.assigns.bow.id}")
         #|> push_patch(to: socket.assigns.patch)
         }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_bow_component(socket, :new, bow_component_params) do
    bow_component_params =
      bow_component_params
      |> Map.put("bow_id", socket.assigns.bow_id)
      |> Map.put("type", socket.assigns.type)
      |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
      |> Enum.into(%{})

    case BowComponents.create_bow_component(bow_component_params) do
      {:ok, bow_component} ->
        IO.inspect(bow_component)
        notify_parent({:saved, bow_component})

        {:noreply,
         socket
         |> put_flash(:info, "Bow component created successfully")
         |> push_navigate(to: "/bows/#{socket.assigns.bow_id}")
         #|> push_patch(to: socket.assigns.patch)
         }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
