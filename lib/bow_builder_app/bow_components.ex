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

  alias BowBuilderApp.BowComponents.OptionValue

  @doc """
  Returns the list of option_values.

  ## Examples

      iex> list_option_values()
      [%OptionValue{}, ...]

  """
  def list_option_values do
    Repo.all(OptionValue)
  end

  @doc """
  Gets a single option_value.

  Raises `Ecto.NoResultsError` if the Option value does not exist.

  ## Examples

      iex> get_option_value!(123)
      %OptionValue{}

      iex> get_option_value!(456)
      ** (Ecto.NoResultsError)

  """
  def get_option_value!(id), do: Repo.get!(OptionValue, id)

  @doc """
  Creates a option_value.

  ## Examples

      iex> create_option_value(%{field: value})
      {:ok, %OptionValue{}}

      iex> create_option_value(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_option_value(attrs \\ %{}) do
    %OptionValue{}
    |> OptionValue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a option_value.

  ## Examples

      iex> update_option_value(option_value, %{field: new_value})
      {:ok, %OptionValue{}}

      iex> update_option_value(option_value, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_option_value(%OptionValue{} = option_value, attrs) do
    option_value
    |> OptionValue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a option_value.

  ## Examples

      iex> delete_option_value(option_value)
      {:ok, %OptionValue{}}

      iex> delete_option_value(option_value)
      {:error, %Ecto.Changeset{}}

  """
  def delete_option_value(%OptionValue{} = option_value) do
    Repo.delete(option_value)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking option_value changes.

  ## Examples

      iex> change_option_value(option_value)
      %Ecto.Changeset{data: %OptionValue{}}

  """
  def change_option_value(%OptionValue{} = option_value, attrs \\ %{}) do
    OptionValue.changeset(option_value, attrs)
  end

  alias BowBuilderApp.BowComponents.OptionType

  @doc """
  Returns the list of option_types.

  ## Examples

      iex> list_option_types()
      [%OptionType{}, ...]

  """
  def list_option_types do
    Repo.all(OptionType)
  end

  def list_option_types(component_id) do
    Repo.all(from ot in OptionType, where: ot.component_id == ^component_id)
  end

  @doc """
  Gets a single option_type.

  Raises `Ecto.NoResultsError` if the Option type does not exist.

  ## Examples

      iex> get_option_type!(123)
      %OptionType{}

      iex> get_option_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_option_type!(id), do: Repo.get!(OptionType, id)

  @doc """
  Creates a option_type.

  ## Examples

      iex> create_option_type(%{field: value})
      {:ok, %OptionType{}}

      iex> create_option_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_option_type(attrs \\ %{}) do
    %OptionType{}
    |> OptionType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a option_type.

  ## Examples

      iex> update_option_type(option_type, %{field: new_value})
      {:ok, %OptionType{}}

      iex> update_option_type(option_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_option_type(%OptionType{} = option_type, attrs) do
    option_type
    |> OptionType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a option_type.

  ## Examples

      iex> delete_option_type(option_type)
      {:ok, %OptionType{}}

      iex> delete_option_type(option_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_option_type(%OptionType{} = option_type) do
    Repo.delete(option_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking option_type changes.

  ## Examples

      iex> change_option_type(option_type)
      %Ecto.Changeset{data: %OptionType{}}

  """
  def change_option_type(%OptionType{} = option_type, attrs \\ %{}) do
    OptionType.changeset(option_type, attrs)
  end

  alias BowBuilderApp.BowComponents.BowOption

  @doc """
  Returns the list of bow_options.

  ## Examples

      iex> list_bow_options()
      [%BowOption{}, ...]

  """
  def list_bow_options do
    Repo.all(BowOption)
  end

  @doc """
  Gets a single bow_option.

  Raises `Ecto.NoResultsError` if the Bow option does not exist.

  ## Examples

      iex> get_bow_option!(123)
      %BowOption{}

      iex> get_bow_option!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bow_option!(id), do: Repo.get!(BowOption, id)

  @doc """
  Creates a bow_option.

  ## Examples

      iex> create_bow_option(%{field: value})
      {:ok, %BowOption{}}

      iex> create_bow_option(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bow_option(attrs \\ %{}) do
    %BowOption{}
    |> BowOption.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bow_option.

  ## Examples

      iex> update_bow_option(bow_option, %{field: new_value})
      {:ok, %BowOption{}}

      iex> update_bow_option(bow_option, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bow_option(%BowOption{} = bow_option, attrs) do
    bow_option
    |> BowOption.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bow_option.

  ## Examples

      iex> delete_bow_option(bow_option)
      {:ok, %BowOption{}}

      iex> delete_bow_option(bow_option)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bow_option(%BowOption{} = bow_option) do
    Repo.delete(bow_option)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bow_option changes.

  ## Examples

      iex> change_bow_option(bow_option)
      %Ecto.Changeset{data: %BowOption{}}

  """
  def change_bow_option(%BowOption{} = bow_option, attrs \\ %{}) do
    BowOption.changeset(bow_option, attrs)
  end
end
