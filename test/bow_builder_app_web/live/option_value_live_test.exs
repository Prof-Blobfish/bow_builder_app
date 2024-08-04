defmodule BowBuilderAppWeb.OptionValueLiveTest do
  use BowBuilderAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import BowBuilderApp.BowComponentsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_option_value(_) do
    option_value = option_value_fixture()
    %{option_value: option_value}
  end

  describe "Index" do
    setup [:create_option_value]

    test "lists all option_values", %{conn: conn, option_value: option_value} do
      {:ok, _index_live, html} = live(conn, ~p"/option_values")

      assert html =~ "Listing Option values"
      assert html =~ option_value.name
    end

    test "saves new option_value", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/option_values")

      assert index_live |> element("a", "New Option value") |> render_click() =~
               "New Option value"

      assert_patch(index_live, ~p"/option_values/new")

      assert index_live
             |> form("#option_value-form", option_value: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#option_value-form", option_value: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/option_values")

      html = render(index_live)
      assert html =~ "Option value created successfully"
      assert html =~ "some name"
    end

    test "updates option_value in listing", %{conn: conn, option_value: option_value} do
      {:ok, index_live, _html} = live(conn, ~p"/option_values")

      assert index_live |> element("#option_values-#{option_value.id} a", "Edit") |> render_click() =~
               "Edit Option value"

      assert_patch(index_live, ~p"/option_values/#{option_value}/edit")

      assert index_live
             |> form("#option_value-form", option_value: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#option_value-form", option_value: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/option_values")

      html = render(index_live)
      assert html =~ "Option value updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes option_value in listing", %{conn: conn, option_value: option_value} do
      {:ok, index_live, _html} = live(conn, ~p"/option_values")

      assert index_live |> element("#option_values-#{option_value.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#option_values-#{option_value.id}")
    end
  end

  describe "Show" do
    setup [:create_option_value]

    test "displays option_value", %{conn: conn, option_value: option_value} do
      {:ok, _show_live, html} = live(conn, ~p"/option_values/#{option_value}")

      assert html =~ "Show Option value"
      assert html =~ option_value.name
    end

    test "updates option_value within modal", %{conn: conn, option_value: option_value} do
      {:ok, show_live, _html} = live(conn, ~p"/option_values/#{option_value}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Option value"

      assert_patch(show_live, ~p"/option_values/#{option_value}/show/edit")

      assert show_live
             |> form("#option_value-form", option_value: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#option_value-form", option_value: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/option_values/#{option_value}")

      html = render(show_live)
      assert html =~ "Option value updated successfully"
      assert html =~ "some updated name"
    end
  end
end
