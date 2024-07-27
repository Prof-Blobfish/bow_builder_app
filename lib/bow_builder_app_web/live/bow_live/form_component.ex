defmodule BowBuilderAppWeb.BowLive.FormComponent do
  use BowBuilderAppWeb, :live_component

  alias BowBuilderApp.BowComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage bow records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bow-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Bow</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bow: bow} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(BowComponents.change_bow(bow))
     end)}
  end

  @impl true
  def handle_event("validate", %{"bow" => bow_params}, socket) do
    changeset = BowComponents.change_bow(socket.assigns.bow, bow_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"bow" => bow_params}, socket) do
    save_bow(socket, socket.assigns.action, bow_params)
  end

  defp save_bow(socket, :edit, bow_params) do
    case BowComponents.update_bow(socket.assigns.bow, bow_params) do
      {:ok, bow} ->
        notify_parent({:saved, bow})

        {:noreply,
         socket
         |> put_flash(:info, "Bow updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_bow(socket, :new, bow_params) do
    case BowComponents.create_bow(bow_params) do
      {:ok, bow} ->
        notify_parent({:saved, bow})

        {:noreply,
         socket
         |> put_flash(:info, "Bow created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
