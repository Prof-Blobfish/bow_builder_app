defmodule BowBuilderApp.BowComponents do
  @moduledoc """
  The BowComponents context.
  """

  import Ecto.Query, warn: false
  alias BowBuilderApp.Repo

  alias BowBuilderApp.BowComponents.Component

  @doc """
  Returns the list of components.

  ## Examples

      iex> list_components()
      [%Component{}, ...]

  """
  def list_components do
    Repo.all(Component)
  end

  @doc """
  Gets a single component.

  Raises `Ecto.NoResultsError` if the Component does not exist.

  ## Examples

      iex> get_component!(123)
      %Component{}

      iex> get_component!(456)
      ** (Ecto.NoResultsError)

  """
  def get_component!(id), do: Repo.get!(Component, id)

  @doc """
  Creates a component.

  ## Examples

      iex> create_component(%{field: value})
      {:ok, %Component{}}

      iex> create_component(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_component(attrs \\ %{}) do
    %Component{}
    |> Component.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a component.

  ## Examples

      iex> update_component(component, %{field: new_value})
      {:ok, %Component{}}

      iex> update_component(component, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_component(%Component{} = component, attrs) do
    component
    |> Component.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a component.

  ## Examples

      iex> delete_component(component)
      {:ok, %Component{}}

      iex> delete_component(component)
      {:error, %Ecto.Changeset{}}

  """
  def delete_component(%Component{} = component) do
    Repo.delete(component)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking component changes.

  ## Examples

      iex> change_component(component)
      %Ecto.Changeset{data: %Component{}}

  """
  def change_component(%Component{} = component, attrs \\ %{}) do
    Component.changeset(component, attrs)
  end

  alias BowBuilderApp.BowComponents.ComponentOption

  @doc """
  Returns the list of component_options.

  ## Examples

      iex> list_component_options()
      [%ComponentOption{}, ...]

  """
  def list_component_options do
    Repo.all(ComponentOption)
  end

  @doc """
  Gets a single component_option.

  Raises `Ecto.NoResultsError` if the Component option does not exist.

  ## Examples

      iex> get_component_option!(123)
      %ComponentOption{}

      iex> get_component_option!(456)
      ** (Ecto.NoResultsError)

  """
  def get_component_option!(id), do: Repo.get!(ComponentOption, id)

  @doc """
  Creates a component_option.

  ## Examples

      iex> create_component_option(%{field: value})
      {:ok, %ComponentOption{}}

      iex> create_component_option(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_component_option(attrs \\ %{}) do
    %ComponentOption{}
    |> ComponentOption.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a component_option.

  ## Examples

      iex> update_component_option(component_option, %{field: new_value})
      {:ok, %ComponentOption{}}

      iex> update_component_option(component_option, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_component_option(%ComponentOption{} = component_option, attrs) do
    component_option
    |> ComponentOption.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a component_option.

  ## Examples

      iex> delete_component_option(component_option)
      {:ok, %ComponentOption{}}

      iex> delete_component_option(component_option)
      {:error, %Ecto.Changeset{}}

  """
  def delete_component_option(%ComponentOption{} = component_option) do
    Repo.delete(component_option)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking component_option changes.

  ## Examples

      iex> change_component_option(component_option)
      %Ecto.Changeset{data: %ComponentOption{}}

  """
  def change_component_option(%ComponentOption{} = component_option, attrs \\ %{}) do
    ComponentOption.changeset(component_option, attrs)
  end

  alias BowBuilderApp.BowComponents.Bow

  @doc """
  Returns the list of bows.

  ## Examples

      iex> list_bows()
      [%Bow{}, ...]

  """
  def list_bows do
    Repo.all(Bow)
  end

  @doc """
  Gets a single bow.

  Raises `Ecto.NoResultsError` if the Bow does not exist.

  ## Examples

      iex> get_bow!(123)
      %Bow{}

      iex> get_bow!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bow!(id), do: Repo.get!(Bow, id)

  @doc """
  Creates a bow.

  ## Examples

      iex> create_bow(%{field: value})
      {:ok, %Bow{}}

      iex> create_bow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bow(attrs \\ %{}) do
    %Bow{}
    |> Bow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bow.

  ## Examples

      iex> update_bow(bow, %{field: new_value})
      {:ok, %Bow{}}

      iex> update_bow(bow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bow(%Bow{} = bow, attrs) do
    bow
    |> Bow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bow.

  ## Examples

      iex> delete_bow(bow)
      {:ok, %Bow{}}

      iex> delete_bow(bow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bow(%Bow{} = bow) do
    Repo.delete(bow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bow changes.

  ## Examples

      iex> change_bow(bow)
      %Ecto.Changeset{data: %Bow{}}

  """
  def change_bow(%Bow{} = bow, attrs \\ %{}) do
    Bow.changeset(bow, attrs)
  end

  alias BowBuilderApp.BowComponents.BowComponent

  @doc """
  Returns the list of bow_components.

  ## Examples

      iex> list_bow_components()
      [%BowComponent{}, ...]

  """
  def list_bow_components do
    Repo.all(BowComponent)
  end

  @doc """
  Gets a single bow_component.

  Raises `Ecto.NoResultsError` if the Bow component does not exist.

  ## Examples

      iex> get_bow_component!(123)
      %BowComponent{}

      iex> get_bow_component!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bow_component!(id), do: Repo.get!(BowComponent, id)

  @doc """
  Creates a bow_component.

  ## Examples

      iex> create_bow_component(%{field: value})
      {:ok, %BowComponent{}}

      iex> create_bow_component(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bow_component(attrs \\ %{}) do
    %BowComponent{}
    |> BowComponent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bow_component.

  ## Examples

      iex> update_bow_component(bow_component, %{field: new_value})
      {:ok, %BowComponent{}}

      iex> update_bow_component(bow_component, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bow_component(%BowComponent{} = bow_component, attrs) do
    bow_component
    |> BowComponent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bow_component.

  ## Examples

      iex> delete_bow_component(bow_component)
      {:ok, %BowComponent{}}

      iex> delete_bow_component(bow_component)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bow_component(%BowComponent{} = bow_component) do
    Repo.delete(bow_component)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bow_component changes.

  ## Examples

      iex> change_bow_component(bow_component)
      %Ecto.Changeset{data: %BowComponent{}}

  """
  def change_bow_component(%BowComponent{} = bow_component, attrs \\ %{}) do
    BowComponent.changeset(bow_component, attrs)
  end
end
