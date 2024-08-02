defmodule BowBuilderAppWeb.OptionTypeLiveTest do
  use BowBuilderAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import BowBuilderApp.BowComponentsFixtures

  @create_attrs %{name: "some name", value: "some value"}
  @update_attrs %{name: "some updated name", value: "some updated value"}
  @invalid_attrs %{name: nil, value: nil}

  defp create_option_type(_) do
    option_type = option_type_fixture()
    %{option_type: option_type}
  end

  describe "Index" do
    setup [:create_option_type]

    test "lists all option_types", %{conn: conn, option_type: option_type} do
      {:ok, _index_live, html} = live(conn, ~p"/option_types")

      assert html =~ "Listing Component options"
      assert html =~ option_type.name
    end

    test "saves new option_type", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/option_types")

      assert index_live |> element("a", "New Component option") |> render_click() =~
               "New Component option"

      assert_patch(index_live, ~p"/option_types/new")

      assert index_live
             |> form("#option_type-form", option_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#option_type-form", option_type: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/option_types")

      html = render(index_live)
      assert html =~ "Component option created successfully"
      assert html =~ "some name"
    end

    test "updates option_type in listing", %{conn: conn, option_type: option_type} do
      {:ok, index_live, _html} = live(conn, ~p"/option_types")

      assert index_live
             |> element("#option_types-#{option_type.id} a", "Edit")
             |> render_click() =~
               "Edit Component option"

      assert_patch(index_live, ~p"/option_types/#{option_type}/edit")

      assert index_live
             |> form("#option_type-form", option_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#option_type-form", option_type: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/option_types")

      html = render(index_live)
      assert html =~ "Component option updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes option_type in listing", %{conn: conn, option_type: option_type} do
      {:ok, index_live, _html} = live(conn, ~p"/option_types")

      assert index_live
             |> element("#option_types-#{option_type.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#option_types-#{option_type.id}")
    end
  end

  describe "Show" do
    setup [:create_option_type]

    test "displays option_type", %{conn: conn, option_type: option_type} do
      {:ok, _show_live, html} = live(conn, ~p"/option_types/#{option_type}")

      assert html =~ "Show Component option"
      assert html =~ option_type.name
    end

    test "updates option_type within modal", %{
      conn: conn,
      option_type: option_type
    } do
      {:ok, show_live, _html} = live(conn, ~p"/option_types/#{option_type}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Component option"

      assert_patch(show_live, ~p"/option_types/#{option_type}/show/edit")

      assert show_live
             |> form("#option_type-form", option_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#option_type-form", option_type: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/option_types/#{option_type}")

      html = render(show_live)
      assert html =~ "Component option updated successfully"
      assert html =~ "some updated name"
    end
  end
end
