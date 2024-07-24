defmodule BowBuilderAppWeb.BowLiveTest do
  use BowBuilderAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import BowBuilderApp.BowComponentsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_bow(_) do
    bow = bow_fixture()
    %{bow: bow}
  end

  describe "Index" do
    setup [:create_bow]

    test "lists all bows", %{conn: conn, bow: bow} do
      {:ok, _index_live, html} = live(conn, ~p"/bows")

      assert html =~ "Listing Bows"
      assert html =~ bow.name
    end

    test "saves new bow", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bows")

      assert index_live |> element("a", "New Bow") |> render_click() =~
               "New Bow"

      assert_patch(index_live, ~p"/bows/new")

      assert index_live
             |> form("#bow-form", bow: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bow-form", bow: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bows")

      html = render(index_live)
      assert html =~ "Bow created successfully"
      assert html =~ "some name"
    end

    test "updates bow in listing", %{conn: conn, bow: bow} do
      {:ok, index_live, _html} = live(conn, ~p"/bows")

      assert index_live |> element("#bows-#{bow.id} a", "Edit") |> render_click() =~
               "Edit Bow"

      assert_patch(index_live, ~p"/bows/#{bow}/edit")

      assert index_live
             |> form("#bow-form", bow: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bow-form", bow: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bows")

      html = render(index_live)
      assert html =~ "Bow updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes bow in listing", %{conn: conn, bow: bow} do
      {:ok, index_live, _html} = live(conn, ~p"/bows")

      assert index_live |> element("#bows-#{bow.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bows-#{bow.id}")
    end
  end

  describe "Show" do
    setup [:create_bow]

    test "displays bow", %{conn: conn, bow: bow} do
      {:ok, _show_live, html} = live(conn, ~p"/bows/#{bow}")

      assert html =~ "Show Bow"
      assert html =~ bow.name
    end

    test "updates bow within modal", %{conn: conn, bow: bow} do
      {:ok, show_live, _html} = live(conn, ~p"/bows/#{bow}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bow"

      assert_patch(show_live, ~p"/bows/#{bow}/show/edit")

      assert show_live
             |> form("#bow-form", bow: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bow-form", bow: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bows/#{bow}")

      html = render(show_live)
      assert html =~ "Bow updated successfully"
      assert html =~ "some updated name"
    end
  end
end
