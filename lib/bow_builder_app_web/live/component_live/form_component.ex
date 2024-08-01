defmodule BowBuilderAppWeb.ComponentLive.FormComponent do
  use BowBuilderAppWeb, :live_component

  alias BowBuilderApp.BowComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage component records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="component-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
      <.input
          field={@form[:type]}
          type="select"
          label="type:"
          options={["riser","limbs","sight","stabs"]}
          prompt="Choose part type"
        />
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Component</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{component: component} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(BowComponents.change_component(component))
     end)}
  end

  @impl true
  def handle_event("validate", %{"component" => component_params}, socket) do
    changeset = BowComponents.change_component(socket.assigns.component, component_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"component" => component_params}, socket) do
    save_component(socket, socket.assigns.action, component_params)
  end

  defp save_component(socket, :edit, component_params) do
    case BowComponents.update_component(socket.assigns.component, component_params) do
      {:ok, component} ->
        notify_parent({:saved, component})

        {:noreply,
         socket
         |> put_flash(:info, "Component updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_component(socket, :new, component_params) do
    case BowComponents.create_component(component_params) do
      {:ok, component} ->
        notify_parent({:saved, component})

        {:noreply,
         socket
         |> put_flash(:info, "Component created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
