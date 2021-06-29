defmodule ShelterMapWeb.PlaceControllerTest do
  use ShelterMapWeb.ConnCase

  alias ShelterMap.Locations

  @create_attrs %{address: "some address", area: "some area", gcode: 42, lat: 120.5, lng: 120.5, name: "some name", villages: "some villages"}
  @update_attrs %{address: "some updated address", area: "some updated area", gcode: 43, lat: 456.7, lng: 456.7, name: "some updated name", villages: "some updated villages"}
  @invalid_attrs %{address: nil, area: nil, gcode: nil, lat: nil, lng: nil, name: nil, villages: nil}

  def fixture(:place) do
    {:ok, place} = Locations.create_place(@create_attrs)
    place
  end

  describe "index" do
    test "lists all place", %{conn: conn} do
      conn = get(conn, Routes.place_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Place"
    end
  end

  describe "new place" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.place_path(conn, :new))
      assert html_response(conn, 200) =~ "New Place"
    end
  end

  describe "create place" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.place_path(conn, :create), place: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.place_path(conn, :show, id)

      conn = get(conn, Routes.place_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Place"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.place_path(conn, :create), place: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Place"
    end
  end

  describe "edit place" do
    setup [:create_place]

    test "renders form for editing chosen place", %{conn: conn, place: place} do
      conn = get(conn, Routes.place_path(conn, :edit, place))
      assert html_response(conn, 200) =~ "Edit Place"
    end
  end

  describe "update place" do
    setup [:create_place]

    test "redirects when data is valid", %{conn: conn, place: place} do
      conn = put(conn, Routes.place_path(conn, :update, place), place: @update_attrs)
      assert redirected_to(conn) == Routes.place_path(conn, :show, place)

      conn = get(conn, Routes.place_path(conn, :show, place))
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, place: place} do
      conn = put(conn, Routes.place_path(conn, :update, place), place: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Place"
    end
  end

  describe "delete place" do
    setup [:create_place]

    test "deletes chosen place", %{conn: conn, place: place} do
      conn = delete(conn, Routes.place_path(conn, :delete, place))
      assert redirected_to(conn) == Routes.place_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.place_path(conn, :show, place))
      end
    end
  end

  defp create_place(_) do
    place = fixture(:place)
    %{place: place}
  end
end
