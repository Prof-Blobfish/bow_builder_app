defmodule BowBuilderAppWeb.ComponentOptionLive.FormComponent do
  use BowBuilderAppWeb, :live_component

  alias BowBuilderApp.BowComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage component_option records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="component_option-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:value]} type="text" label="Value" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Component option</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{component_option: component_option} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(BowComponents.change_component_option(component_option))
     end)}
  end

  @impl true
  def handle_event("validate", %{"component_option" => component_option_params}, socket) do
    changeset = BowComponents.change_component_option(socket.assigns.component_option, component_option_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"component_option" => component_option_params}, socket) do
    save_component_option(socket, socket.assigns.action, component_option_params)
  end

  defp save_component_option(socket, :edit, component_option_params) do
    case BowComponents.update_component_option(socket.assigns.component_option, component_option_params) do
      {:ok, component_option} ->
        notify_parent({:saved, component_option})

        {:noreply,
         socket
         |> put_flash(:info, "Component option updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_component_option(socket, :new, component_option_params) do
    case BowComponents.create_component_option(component_option_params) do
      {:ok, component_option} ->
        notify_parent({:saved, component_option})

        {:noreply,
         socket
         |> put_flash(:info, "Component option created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
