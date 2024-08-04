defmodule BowBuilderAppWeb.BowOptionLiveTest do
  use BowBuilderAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import BowBuilderApp.BowComponentsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_bow_option(_) do
    bow_option = bow_option_fixture()
    %{bow_option: bow_option}
  end

  describe "Index" do
    setup [:create_bow_option]

    test "lists all bow_options", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/bow_options")

      assert html =~ "Listing Bow options"
    end

    test "saves new bow_option", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bow_options")

      assert index_live |> element("a", "New Bow option") |> render_click() =~
               "New Bow option"

      assert_patch(index_live, ~p"/bow_options/new")

      assert index_live
             |> form("#bow_option-form", bow_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bow_option-form", bow_option: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bow_options")

      html = render(index_live)
      assert html =~ "Bow option created successfully"
    end

    test "updates bow_option in listing", %{conn: conn, bow_option: bow_option} do
      {:ok, index_live, _html} = live(conn, ~p"/bow_options")

      assert index_live |> element("#bow_options-#{bow_option.id} a", "Edit") |> render_click() =~
               "Edit Bow option"

      assert_patch(index_live, ~p"/bow_options/#{bow_option}/edit")

      assert index_live
             |> form("#bow_option-form", bow_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bow_option-form", bow_option: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bow_options")

      html = render(index_live)
      assert html =~ "Bow option updated successfully"
    end

    test "deletes bow_option in listing", %{conn: conn, bow_option: bow_option} do
      {:ok, index_live, _html} = live(conn, ~p"/bow_options")

      assert index_live |> element("#bow_options-#{bow_option.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bow_options-#{bow_option.id}")
    end
  end

  describe "Show" do
    setup [:create_bow_option]

    test "displays bow_option", %{conn: conn, bow_option: bow_option} do
      {:ok, _show_live, html} = live(conn, ~p"/bow_options/#{bow_option}")

      assert html =~ "Show Bow option"
    end

    test "updates bow_option within modal", %{conn: conn, bow_option: bow_option} do
      {:ok, show_live, _html} = live(conn, ~p"/bow_options/#{bow_option}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bow option"

      assert_patch(show_live, ~p"/bow_options/#{bow_option}/show/edit")

      assert show_live
             |> form("#bow_option-form", bow_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bow_option-form", bow_option: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bow_options/#{bow_option}")

      html = render(show_live)
      assert html =~ "Bow option updated successfully"
    end
  end
end
