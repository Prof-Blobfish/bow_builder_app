defmodule BowBuilderAppWeb.ComponentOptionLiveTest do
  use BowBuilderAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import BowBuilderApp.BowComponentsFixtures

  @create_attrs %{name: "some name", value: "some value"}
  @update_attrs %{name: "some updated name", value: "some updated value"}
  @invalid_attrs %{name: nil, value: nil}

  defp create_component_option(_) do
    component_option = component_option_fixture()
    %{component_option: component_option}
  end

  describe "Index" do
    setup [:create_component_option]

    test "lists all component_options", %{conn: conn, component_option: component_option} do
      {:ok, _index_live, html} = live(conn, ~p"/component_options")

      assert html =~ "Listing Component options"
      assert html =~ component_option.name
    end

    test "saves new component_option", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/component_options")

      assert index_live |> element("a", "New Component option") |> render_click() =~
               "New Component option"

      assert_patch(index_live, ~p"/component_options/new")

      assert index_live
             |> form("#component_option-form", component_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#component_option-form", component_option: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/component_options")

      html = render(index_live)
      assert html =~ "Component option created successfully"
      assert html =~ "some name"
    end

    test "updates component_option in listing", %{conn: conn, component_option: component_option} do
      {:ok, index_live, _html} = live(conn, ~p"/component_options")

      assert index_live
             |> element("#component_options-#{component_option.id} a", "Edit")
             |> render_click() =~
               "Edit Component option"

      assert_patch(index_live, ~p"/component_options/#{component_option}/edit")

      assert index_live
             |> form("#component_option-form", component_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#component_option-form", component_option: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/component_options")

      html = render(index_live)
      assert html =~ "Component option updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes component_option in listing", %{conn: conn, component_option: component_option} do
      {:ok, index_live, _html} = live(conn, ~p"/component_options")

      assert index_live
             |> element("#component_options-#{component_option.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#component_options-#{component_option.id}")
    end
  end

  describe "Show" do
    setup [:create_component_option]

    test "displays component_option", %{conn: conn, component_option: component_option} do
      {:ok, _show_live, html} = live(conn, ~p"/component_options/#{component_option}")

      assert html =~ "Show Component option"
      assert html =~ component_option.name
    end

    test "updates component_option within modal", %{
      conn: conn,
      component_option: component_option
    } do
      {:ok, show_live, _html} = live(conn, ~p"/component_options/#{component_option}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Component option"

      assert_patch(show_live, ~p"/component_options/#{component_option}/show/edit")

      assert show_live
             |> form("#component_option-form", component_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#component_option-form", component_option: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/component_options/#{component_option}")

      html = render(show_live)
      assert html =~ "Component option updated successfully"
      assert html =~ "some updated name"
    end
  end
end
