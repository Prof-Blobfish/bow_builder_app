defmodule BowBuilderAppWeb.OptionTypeLive.FormComponent do
  use BowBuilderAppWeb, :live_component

  alias BowBuilderApp.BowComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage option_type records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="option_type-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Option type</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{option_type: option_type, component_id: component_id} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:component_id, component_id)
     |> assign_new(:form, fn ->
       to_form(BowComponents.change_option_type(option_type))
     end)}
  end

  @impl true
  def handle_event("validate", %{"option_type" => option_type_params}, socket) do
    changeset = BowComponents.change_option_type(socket.assigns.option_type, option_type_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"option_type" => option_type_params}, socket) do
    option_type_params = Map.put(option_type_params, "component_id", socket.assigns.component_id)
    save_option_type(socket, socket.assigns.action, option_type_params)
  end

  defp save_option_type(socket, :edit, option_type_params) do
    case BowComponents.update_option_type(socket.assigns.option_type, option_type_params) do
      {:ok, option_type} ->
        notify_parent({:saved, option_type})

        {:noreply,
         socket
         |> put_flash(:info, "Option type updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_option_type(socket, :new, option_type_params) do
    case BowComponents.create_option_type(option_type_params) do
      {:ok, option_type} ->
        notify_parent({:saved, option_type})

        {:noreply,
         socket
         |> put_flash(:info, "Option type created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
