defmodule BowBuilderAppWeb.BowOptionLive.FormComponent do
  use BowBuilderAppWeb, :live_component

  alias BowBuilderApp.BowComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage bow_option records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bow_option-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Bow option</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bow_option: bow_option} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(BowComponents.change_bow_option(bow_option))
     end)}
  end

  @impl true
  def handle_event("validate", %{"bow_option" => bow_option_params}, socket) do
    changeset = BowComponents.change_bow_option(socket.assigns.bow_option, bow_option_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"bow_option" => bow_option_params}, socket) do
    save_bow_option(socket, socket.assigns.action, bow_option_params)
  end

  defp save_bow_option(socket, :edit, bow_option_params) do
    case BowComponents.update_bow_option(socket.assigns.bow_option, bow_option_params) do
      {:ok, bow_option} ->
        notify_parent({:saved, bow_option})

        {:noreply,
         socket
         |> put_flash(:info, "Bow option updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_bow_option(socket, :new, bow_option_params) do
    case BowComponents.create_bow_option(bow_option_params) do
      {:ok, bow_option} ->
        notify_parent({:saved, bow_option})

        {:noreply,
         socket
         |> put_flash(:info, "Bow option created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
