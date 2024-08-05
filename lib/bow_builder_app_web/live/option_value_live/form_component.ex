defmodule BowBuilderAppWeb.OptionValueLive.FormComponent do
  use BowBuilderAppWeb, :live_component

  alias BowBuilderApp.BowComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage option_value records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="option_value-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Option value</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{option_value: option_value, option_type_id: option_type_id} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:option_type_id, option_type_id)
     |> assign_new(:form, fn ->
       to_form(BowComponents.change_option_value(option_value))
     end)}
  end

  @impl true
  def handle_event("validate", %{"option_value" => option_value_params}, socket) do
    changeset = BowComponents.change_option_value(socket.assigns.option_value, option_value_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"option_value" => option_value_params}, socket) do
    option_value_params = Map.put(option_value_params, "option_type_id", socket.assigns.option_type_id)
    save_option_value(socket, socket.assigns.action, option_value_params)
  end

  defp save_option_value(socket, :edit, option_value_params) do
    case BowComponents.update_option_value(socket.assigns.option_value, option_value_params) do
      {:ok, option_value} ->
        notify_parent({:saved, option_value})

        {:noreply,
         socket
         |> put_flash(:info, "Option value updated successfully")
         |> push_patch(to: socket.assigns.patch)}
         |> IO.inspect()

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_option_value(socket, :new, option_value_params) do
    case BowComponents.create_option_value(option_value_params) do
      {:ok, option_value} ->
        notify_parent({:saved, option_value})

        {:noreply,
         socket
         |> put_flash(:info, "Option value created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
