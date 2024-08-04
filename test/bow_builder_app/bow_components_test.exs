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

      assert {:ok, %Component{} = component} =
               BowComponents.update_component(component, update_attrs)

      assert component.name == "some updated name"
      assert component.type == "some updated type"
      assert component.price == 456.7
    end

    test "update_component/2 with invalid data returns error changeset" do
      component = component_fixture()

      assert {:error, %Ecto.Changeset{}} =
               BowComponents.update_component(component, @invalid_attrs)

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

  describe "option_types" do
    alias BowBuilderApp.BowComponents.OptionType

    import BowBuilderApp.BowComponentsFixtures

    @invalid_attrs %{name: nil, value: nil}

    test "list_option_types/0 returns all option_types" do
      option_type = option_type_fixture()
      assert BowComponents.list_option_types() == [option_type]
    end

    test "get_option_type!/1 returns the option_type with given id" do
      option_type = option_type_fixture()
      assert BowComponents.get_option_type!(option_type.id) == option_type
    end

    test "create_option_type/1 with valid data creates a option_type" do
      valid_attrs = %{name: "some name", value: "some value"}

      assert {:ok, %OptionType{} = option_type} =
               BowComponents.create_option_type(valid_attrs)

      assert option_type.name == "some name"
      assert option_type.value == "some value"
    end

    test "create_option_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BowComponents.create_option_type(@invalid_attrs)
    end

    test "update_option_type/2 with valid data updates the option_type" do
      option_type = option_type_fixture()
      update_attrs = %{name: "some updated name", value: "some updated value"}

      assert {:ok, %OptionType{} = option_type} =
               BowComponents.update_option_type(option_type, update_attrs)

      assert option_type.name == "some updated name"
      assert option_type.value == "some updated value"
    end

    test "update_option_type/2 with invalid data returns error changeset" do
      option_type = option_type_fixture()

      assert {:error, %Ecto.Changeset{}} =
               BowComponents.update_option_type(option_type, @invalid_attrs)

      assert option_type == BowComponents.get_option_type!(option_type.id)
    end

    test "delete_option_type/1 deletes the option_type" do
      option_type = option_type_fixture()
      assert {:ok, %OptionType{}} = BowComponents.delete_option_type(option_type)

      assert_raise Ecto.NoResultsError, fn ->
        BowComponents.get_option_type!(option_type.id)
      end
    end

    test "change_option_type/1 returns a option_type changeset" do
      option_type = option_type_fixture()
      assert %Ecto.Changeset{} = BowComponents.change_option_type(option_type)
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

      assert {:ok, %BowComponent{} = bow_component} =
               BowComponents.create_bow_component(valid_attrs)

      assert bow_component.option_values == %{}
    end

    test "create_bow_component/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BowComponents.create_bow_component(@invalid_attrs)
    end

    test "update_bow_component/2 with valid data updates the bow_component" do
      bow_component = bow_component_fixture()
      update_attrs = %{option_values: %{}}

      assert {:ok, %BowComponent{} = bow_component} =
               BowComponents.update_bow_component(bow_component, update_attrs)

      assert bow_component.option_values == %{}
    end

    test "update_bow_component/2 with invalid data returns error changeset" do
      bow_component = bow_component_fixture()

      assert {:error, %Ecto.Changeset{}} =
               BowComponents.update_bow_component(bow_component, @invalid_attrs)

      assert bow_component == BowComponents.get_bow_component!(bow_component.id)
    end

    test "delete_bow_component/1 deletes the bow_component" do
      bow_component = bow_component_fixture()
      assert {:ok, %BowComponent{}} = BowComponents.delete_bow_component(bow_component)

      assert_raise Ecto.NoResultsError, fn ->
        BowComponents.get_bow_component!(bow_component.id)
      end
    end

    test "change_bow_component/1 returns a bow_component changeset" do
      bow_component = bow_component_fixture()
      assert %Ecto.Changeset{} = BowComponents.change_bow_component(bow_component)
    end
  end

  describe "option_values" do
    alias BowBuilderApp.BowComponents.OptionValue

    import BowBuilderApp.BowComponentsFixtures

    @invalid_attrs %{value: nil}

    test "list_option_values/0 returns all option_values" do
      option_value = option_value_fixture()
      assert BowComponents.list_option_values() == [option_value]
    end

    test "get_option_value!/1 returns the option_value with given id" do
      option_value = option_value_fixture()
      assert BowComponents.get_option_value!(option_value.id) == option_value
    end

    test "create_option_value/1 with valid data creates a option_value" do
      valid_attrs = %{value: "some value"}

      assert {:ok, %OptionValue{} = option_value} = BowComponents.create_option_value(valid_attrs)
      assert option_value.value == "some value"
    end

    test "create_option_value/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BowComponents.create_option_value(@invalid_attrs)
    end

    test "update_option_value/2 with valid data updates the option_value" do
      option_value = option_value_fixture()
      update_attrs = %{value: "some updated value"}

      assert {:ok, %OptionValue{} = option_value} = BowComponents.update_option_value(option_value, update_attrs)
      assert option_value.value == "some updated value"
    end

    test "update_option_value/2 with invalid data returns error changeset" do
      option_value = option_value_fixture()
      assert {:error, %Ecto.Changeset{}} = BowComponents.update_option_value(option_value, @invalid_attrs)
      assert option_value == BowComponents.get_option_value!(option_value.id)
    end

    test "delete_option_value/1 deletes the option_value" do
      option_value = option_value_fixture()
      assert {:ok, %OptionValue{}} = BowComponents.delete_option_value(option_value)
      assert_raise Ecto.NoResultsError, fn -> BowComponents.get_option_value!(option_value.id) end
    end

    test "change_option_value/1 returns a option_value changeset" do
      option_value = option_value_fixture()
      assert %Ecto.Changeset{} = BowComponents.change_option_value(option_value)
    end
  end

  describe "option_types" do
    alias BowBuilderApp.BowComponents.OptionType

    import BowBuilderApp.BowComponentsFixtures

    @invalid_attrs %{name: nil}

    test "list_option_types/0 returns all option_types" do
      option_type = option_type_fixture()
      assert BowComponents.list_option_types() == [option_type]
    end

    test "get_option_type!/1 returns the option_type with given id" do
      option_type = option_type_fixture()
      assert BowComponents.get_option_type!(option_type.id) == option_type
    end

    test "create_option_type/1 with valid data creates a option_type" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %OptionType{} = option_type} = BowComponents.create_option_type(valid_attrs)
      assert option_type.name == "some name"
    end

    test "create_option_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BowComponents.create_option_type(@invalid_attrs)
    end

    test "update_option_type/2 with valid data updates the option_type" do
      option_type = option_type_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %OptionType{} = option_type} = BowComponents.update_option_type(option_type, update_attrs)
      assert option_type.name == "some updated name"
    end

    test "update_option_type/2 with invalid data returns error changeset" do
      option_type = option_type_fixture()
      assert {:error, %Ecto.Changeset{}} = BowComponents.update_option_type(option_type, @invalid_attrs)
      assert option_type == BowComponents.get_option_type!(option_type.id)
    end

    test "delete_option_type/1 deletes the option_type" do
      option_type = option_type_fixture()
      assert {:ok, %OptionType{}} = BowComponents.delete_option_type(option_type)
      assert_raise Ecto.NoResultsError, fn -> BowComponents.get_option_type!(option_type.id) end
    end

    test "change_option_type/1 returns a option_type changeset" do
      option_type = option_type_fixture()
      assert %Ecto.Changeset{} = BowComponents.change_option_type(option_type)
    end
  end

  describe "option_values" do
    alias BowBuilderApp.BowComponents.OptionValue

    import BowBuilderApp.BowComponentsFixtures

    @invalid_attrs %{name: nil}

    test "list_option_values/0 returns all option_values" do
      option_value = option_value_fixture()
      assert BowComponents.list_option_values() == [option_value]
    end

    test "get_option_value!/1 returns the option_value with given id" do
      option_value = option_value_fixture()
      assert BowComponents.get_option_value!(option_value.id) == option_value
    end

    test "create_option_value/1 with valid data creates a option_value" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %OptionValue{} = option_value} = BowComponents.create_option_value(valid_attrs)
      assert option_value.name == "some name"
    end

    test "create_option_value/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BowComponents.create_option_value(@invalid_attrs)
    end

    test "update_option_value/2 with valid data updates the option_value" do
      option_value = option_value_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %OptionValue{} = option_value} = BowComponents.update_option_value(option_value, update_attrs)
      assert option_value.name == "some updated name"
    end

    test "update_option_value/2 with invalid data returns error changeset" do
      option_value = option_value_fixture()
      assert {:error, %Ecto.Changeset{}} = BowComponents.update_option_value(option_value, @invalid_attrs)
      assert option_value == BowComponents.get_option_value!(option_value.id)
    end

    test "delete_option_value/1 deletes the option_value" do
      option_value = option_value_fixture()
      assert {:ok, %OptionValue{}} = BowComponents.delete_option_value(option_value)
      assert_raise Ecto.NoResultsError, fn -> BowComponents.get_option_value!(option_value.id) end
    end

    test "change_option_value/1 returns a option_value changeset" do
      option_value = option_value_fixture()
      assert %Ecto.Changeset{} = BowComponents.change_option_value(option_value)
    end
  end

  describe "bow_options" do
    alias BowBuilderApp.BowComponents.BowOption

    import BowBuilderApp.BowComponentsFixtures

    @invalid_attrs %{}

    test "list_bow_options/0 returns all bow_options" do
      bow_option = bow_option_fixture()
      assert BowComponents.list_bow_options() == [bow_option]
    end

    test "get_bow_option!/1 returns the bow_option with given id" do
      bow_option = bow_option_fixture()
      assert BowComponents.get_bow_option!(bow_option.id) == bow_option
    end

    test "create_bow_option/1 with valid data creates a bow_option" do
      valid_attrs = %{}

      assert {:ok, %BowOption{} = bow_option} = BowComponents.create_bow_option(valid_attrs)
    end

    test "create_bow_option/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BowComponents.create_bow_option(@invalid_attrs)
    end

    test "update_bow_option/2 with valid data updates the bow_option" do
      bow_option = bow_option_fixture()
      update_attrs = %{}

      assert {:ok, %BowOption{} = bow_option} = BowComponents.update_bow_option(bow_option, update_attrs)
    end

    test "update_bow_option/2 with invalid data returns error changeset" do
      bow_option = bow_option_fixture()
      assert {:error, %Ecto.Changeset{}} = BowComponents.update_bow_option(bow_option, @invalid_attrs)
      assert bow_option == BowComponents.get_bow_option!(bow_option.id)
    end

    test "delete_bow_option/1 deletes the bow_option" do
      bow_option = bow_option_fixture()
      assert {:ok, %BowOption{}} = BowComponents.delete_bow_option(bow_option)
      assert_raise Ecto.NoResultsError, fn -> BowComponents.get_bow_option!(bow_option.id) end
    end

    test "change_bow_option/1 returns a bow_option changeset" do
      bow_option = bow_option_fixture()
      assert %Ecto.Changeset{} = BowComponents.change_bow_option(bow_option)
    end
  end
end
