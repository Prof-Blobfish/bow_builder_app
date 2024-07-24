defmodule BowBuilderApp.BowComponentsTest do
  use BowBuilderApp.DataCase

  alias BowBuilderApp.BowComponents

  describe "components" do
    alias BowBuilderApp.BowComponents.Component

    import BowBuilderApp.BowComponentsFixtures

    @invalid_attrs %{name: nil, type: nil, price: nil}

    test "list_components/0 returns all components" do
      component = component_fixture()
      assert BowComponents.list_components() == [component]
    end

    test "get_component!/1 returns the component with given id" do
      component = component_fixture()
      assert BowComponents.get_component!(component.id) == component
    end

    test "create_component/1 with valid data creates a component" do
      valid_attrs = %{name: "some name", type: "some type", price: 120.5}

      assert {:ok, %Component{} = component} = BowComponents.create_component(valid_attrs)
      assert component.name == "some name"
      assert component.type == "some type"
      assert component.price == 120.5
    end

    test "create_component/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BowComponents.create_component(@invalid_attrs)
    end

    test "update_component/2 with valid data updates the component" do
      component = component_fixture()
      update_attrs = %{name: "some updated name", type: "some updated type", price: 456.7}

      assert {:ok, %Component{} = component} = BowComponents.update_component(component, update_attrs)
      assert component.name == "some updated name"
      assert component.type == "some updated type"
      assert component.price == 456.7
    end

    test "update_component/2 with invalid data returns error changeset" do
      component = component_fixture()
      assert {:error, %Ecto.Changeset{}} = BowComponents.update_component(component, @invalid_attrs)
      assert component == BowComponents.get_component!(component.id)
    end

    test "delete_component/1 deletes the component" do
      component = component_fixture()
      assert {:ok, %Component{}} = BowComponents.delete_component(component)
      assert_raise Ecto.NoResultsError, fn -> BowComponents.get_component!(component.id) end
    end

    test "change_component/1 returns a component changeset" do
      component = component_fixture()
      assert %Ecto.Changeset{} = BowComponents.change_component(component)
    end
  end

  describe "component_options" do
    alias BowBuilderApp.BowComponents.ComponentOption

    import BowBuilderApp.BowComponentsFixtures

    @invalid_attrs %{name: nil, value: nil}

    test "list_component_options/0 returns all component_options" do
      component_option = component_option_fixture()
      assert BowComponents.list_component_options() == [component_option]
    end

    test "get_component_option!/1 returns the component_option with given id" do
      component_option = component_option_fixture()
      assert BowComponents.get_component_option!(component_option.id) == component_option
    end

    test "create_component_option/1 with valid data creates a component_option" do
      valid_attrs = %{name: "some name", value: "some value"}

      assert {:ok, %ComponentOption{} = component_option} = BowComponents.create_component_option(valid_attrs)
      assert component_option.name == "some name"
      assert component_option.value == "some value"
    end

    test "create_component_option/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BowComponents.create_component_option(@invalid_attrs)
    end

    test "update_component_option/2 with valid data updates the component_option" do
      component_option = component_option_fixture()
      update_attrs = %{name: "some updated name", value: "some updated value"}

      assert {:ok, %ComponentOption{} = component_option} = BowComponents.update_component_option(component_option, update_attrs)
      assert component_option.name == "some updated name"
      assert component_option.value == "some updated value"
    end

    test "update_component_option/2 with invalid data returns error changeset" do
      component_option = component_option_fixture()
      assert {:error, %Ecto.Changeset{}} = BowComponents.update_component_option(component_option, @invalid_attrs)
      assert component_option == BowComponents.get_component_option!(component_option.id)
    end

    test "delete_component_option/1 deletes the component_option" do
      component_option = component_option_fixture()
      assert {:ok, %ComponentOption{}} = BowComponents.delete_component_option(component_option)
      assert_raise Ecto.NoResultsError, fn -> BowComponents.get_component_option!(component_option.id) end
    end

    test "change_component_option/1 returns a component_option changeset" do
      component_option = component_option_fixture()
      assert %Ecto.Changeset{} = BowComponents.change_component_option(component_option)
    end
  end

  describe "bows" do
    alias BowBuilderApp.BowComponents.Bow

    import BowBuilderApp.BowComponentsFixtures

    @invalid_attrs %{name: nil}

    test "list_bows/0 returns all bows" do
      bow = bow_fixture()
      assert BowComponents.list_bows() == [bow]
    end

    test "get_bow!/1 returns the bow with given id" do
      bow = bow_fixture()
      assert BowComponents.get_bow!(bow.id) == bow
    end

    test "create_bow/1 with valid data creates a bow" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Bow{} = bow} = BowComponents.create_bow(valid_attrs)
      assert bow.name == "some name"
    end

    test "create_bow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BowComponents.create_bow(@invalid_attrs)
    end

    test "update_bow/2 with valid data updates the bow" do
      bow = bow_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Bow{} = bow} = BowComponents.update_bow(bow, update_attrs)
      assert bow.name == "some updated name"
    end

    test "update_bow/2 with invalid data returns error changeset" do
      bow = bow_fixture()
      assert {:error, %Ecto.Changeset{}} = BowComponents.update_bow(bow, @invalid_attrs)
      assert bow == BowComponents.get_bow!(bow.id)
    end

    test "delete_bow/1 deletes the bow" do
      bow = bow_fixture()
      assert {:ok, %Bow{}} = BowComponents.delete_bow(bow)
      assert_raise Ecto.NoResultsError, fn -> BowComponents.get_bow!(bow.id) end
    end

    test "change_bow/1 returns a bow changeset" do
      bow = bow_fixture()
      assert %Ecto.Changeset{} = BowComponents.change_bow(bow)
    end
  end

  describe "bow_components" do
    alias BowBuilderApp.BowComponents.BowComponent

    import BowBuilderApp.BowComponentsFixtures

    @invalid_attrs %{option_values: nil}

    test "list_bow_components/0 returns all bow_components" do
      bow_component = bow_component_fixture()
      assert BowComponents.list_bow_components() == [bow_component]
    end

    test "get_bow_component!/1 returns the bow_component with given id" do
      bow_component = bow_component_fixture()
      assert BowComponents.get_bow_component!(bow_component.id) == bow_component
    end

    test "create_bow_component/1 with valid data creates a bow_component" do
      valid_attrs = %{option_values: %{}}

      assert {:ok, %BowComponent{} = bow_component} = BowComponents.create_bow_component(valid_attrs)
      assert bow_component.option_values == %{}
    end

    test "create_bow_component/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BowComponents.create_bow_component(@invalid_attrs)
    end

    test "update_bow_component/2 with valid data updates the bow_component" do
      bow_component = bow_component_fixture()
      update_attrs = %{option_values: %{}}

      assert {:ok, %BowComponent{} = bow_component} = BowComponents.update_bow_component(bow_component, update_attrs)
      assert bow_component.option_values == %{}
    end

    test "update_bow_component/2 with invalid data returns error changeset" do
      bow_component = bow_component_fixture()
      assert {:error, %Ecto.Changeset{}} = BowComponents.update_bow_component(bow_component, @invalid_attrs)
      assert bow_component == BowComponents.get_bow_component!(bow_component.id)
    end

    test "delete_bow_component/1 deletes the bow_component" do
      bow_component = bow_component_fixture()
      assert {:ok, %BowComponent{}} = BowComponents.delete_bow_component(bow_component)
      assert_raise Ecto.NoResultsError, fn -> BowComponents.get_bow_component!(bow_component.id) end
    end

    test "change_bow_component/1 returns a bow_component changeset" do
      bow_component = bow_component_fixture()
      assert %Ecto.Changeset{} = BowComponents.change_bow_component(bow_component)
    end
  end
end
