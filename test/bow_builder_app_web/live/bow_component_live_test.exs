defmodule BowBuilderAppWeb.BowComponentLiveTest do
  use BowBuilderAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import BowBuilderApp.BowComponentsFixtures

  @create_attrs %{option_values: %{}}
  @update_attrs %{option_values: %{}}
  @invalid_attrs %{option_values: nil}

  defp create_bow_component(_) do
    bow_component = bow_component_fixture()
    %{bow_component: bow_component}
  end

  describe "Index" do
    setup [:create_bow_component]

    test "lists all bow_components", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/bow_components")

      assert html =~ "Listing Bow components"
    end

    test "saves new bow_component", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bow_components")

      assert index_live |> element("a", "New Bow component") |> render_click() =~
               "New Bow component"

      assert_patch(index_live, ~p"/bow_components/new")

      assert index_live
             |> form("#bow_component-form", bow_component: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bow_component-form", bow_component: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bow_components")

      html = render(index_live)
      assert html =~ "Bow component created successfully"
    end

    test "updates bow_component in listing", %{conn: conn, bow_component: bow_component} do
      {:ok, index_live, _html} = live(conn, ~p"/bow_components")

      assert index_live
             |> element("#bow_components-#{bow_component.id} a", "Edit")
             |> render_click() =~
               "Edit Bow component"

      assert_patch(index_live, ~p"/bow_components/#{bow_component}/edit")

      assert index_live
             |> form("#bow_component-form", bow_component: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bow_component-form", bow_component: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bow_components")

      html = render(index_live)
      assert html =~ "Bow component updated successfully"
    end

    test "deletes bow_component in listing", %{conn: conn, bow_component: bow_component} do
      {:ok, index_live, _html} = live(conn, ~p"/bow_components")

      assert index_live
             |> element("#bow_components-#{bow_component.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#bow_components-#{bow_component.id}")
    end
  end

  describe "Show" do
    setup [:create_bow_component]

    test "displays bow_component", %{conn: conn, bow_component: bow_component} do
      {:ok, _show_live, html} = live(conn, ~p"/bow_components/#{bow_component}")

      assert html =~ "Show Bow component"
    end

    test "updates bow_component within modal", %{conn: conn, bow_component: bow_component} do
      {:ok, show_live, _html} = live(conn, ~p"/bow_components/#{bow_component}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bow component"

      assert_patch(show_live, ~p"/bow_components/#{bow_component}/show/edit")

      assert show_live
             |> form("#bow_component-form", bow_component: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bow_component-form", bow_component: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bow_components/#{bow_component}")

      html = render(show_live)
      assert html =~ "Bow component updated successfully"
    end
  end
end
