defmodule BowBuilderAppWeb.ComponentLiveTest do
  use BowBuilderAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import BowBuilderApp.BowComponentsFixtures

  @create_attrs %{name: "some name", type: "some type", price: 120.5}
  @update_attrs %{name: "some updated name", type: "some updated type", price: 456.7}
  @invalid_attrs %{name: nil, type: nil, price: nil}

  defp create_component(_) do
    component = component_fixture()
    %{component: component}
  end

  describe "Index" do
    setup [:create_component]

    test "lists all components", %{conn: conn, component: component} do
      {:ok, _index_live, html} = live(conn, ~p"/components")

      assert html =~ "Listing Components"
      assert html =~ component.name
    end

    test "saves new component", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/components")

      assert index_live |> element("a", "New Component") |> render_click() =~
               "New Component"

      assert_patch(index_live, ~p"/components/new")

      assert index_live
             |> form("#component-form", component: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#component-form", component: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/components")

      html = render(index_live)
      assert html =~ "Component created successfully"
      assert html =~ "some name"
    end

    test "updates component in listing", %{conn: conn, component: component} do
      {:ok, index_live, _html} = live(conn, ~p"/components")

      assert index_live |> element("#components-#{component.id} a", "Edit") |> render_click() =~
               "Edit Component"

      assert_patch(index_live, ~p"/components/#{component}/edit")

      assert index_live
             |> form("#component-form", component: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#component-form", component: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/components")

      html = render(index_live)
      assert html =~ "Component updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes component in listing", %{conn: conn, component: component} do
      {:ok, index_live, _html} = live(conn, ~p"/components")

      assert index_live |> element("#components-#{component.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#components-#{component.id}")
    end
  end

  describe "Show" do
    setup [:create_component]

    test "displays component", %{conn: conn, component: component} do
      {:ok, _show_live, html} = live(conn, ~p"/components/#{component}")

      assert html =~ "Show Component"
      assert html =~ component.name
    end

    test "updates component within modal", %{conn: conn, component: component} do
      {:ok, show_live, _html} = live(conn, ~p"/components/#{component}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Component"

      assert_patch(show_live, ~p"/components/#{component}/show/edit")

      assert show_live
             |> form("#component-form", component: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#component-form", component: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/components/#{component}")

      html = render(show_live)
      assert html =~ "Component updated successfully"
      assert html =~ "some updated name"
    end
  end
end
