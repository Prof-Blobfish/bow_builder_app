defmodule BowBuilderApp.BowComponentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BowBuilderApp.BowComponents` context.
  """

  @doc """
  Generate a component.
  """
  def component_fixture(attrs \\ %{}) do
    {:ok, component} =
      attrs
      |> Enum.into(%{
        name: "some name",
        price: 120.5,
        type: "some type"
      })
      |> BowBuilderApp.BowComponents.create_component()

    component
  end

  @doc """
  Generate a option_type.
  """
  def option_type_fixture(attrs \\ %{}) do
    {:ok, option_type} =
      attrs
      |> Enum.into(%{
        name: "some name",
        value: "some value"
      })
      |> BowBuilderApp.BowComponents.create_option_type()

    option_type
  end

  @doc """
  Generate a bow.
  """
  def bow_fixture(attrs \\ %{}) do
    {:ok, bow} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> BowBuilderApp.BowComponents.create_bow()

    bow
  end

  @doc """
  Generate a bow_component.
  """
  def bow_component_fixture(attrs \\ %{}) do
    {:ok, bow_component} =
      attrs
      |> Enum.into(%{
        option_values: %{}
      })
      |> BowBuilderApp.BowComponents.create_bow_component()

    bow_component
  end
end
