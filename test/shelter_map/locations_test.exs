defmodule ShelterMap.LocationsTest do
  use ShelterMap.DataCase

  alias ShelterMap.Locations

  describe "place" do
    alias ShelterMap.Locations.Place

    @valid_attrs %{address: "some address", area: "some area", gcode: 42, lat: 120.5, lng: 120.5, name: "some name", villages: "some villages"}
    @update_attrs %{address: "some updated address", area: "some updated area", gcode: 43, lat: 456.7, lng: 456.7, name: "some updated name", villages: "some updated villages"}
    @invalid_attrs %{address: nil, area: nil, gcode: nil, lat: nil, lng: nil, name: nil, villages: nil}

    def place_fixture(attrs \\ %{}) do
      {:ok, place} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Locations.create_place()

      place
    end

    test "list_place/0 returns all place" do
      place = place_fixture()
      assert Locations.list_place() == [place]
    end

    test "get_place!/1 returns the place with given id" do
      place = place_fixture()
      assert Locations.get_place!(place.id) == place
    end

    test "create_place/1 with valid data creates a place" do
      assert {:ok, %Place{} = place} = Locations.create_place(@valid_attrs)
      assert place.address == "some address"
      assert place.area == "some area"
      assert place.gcode == 42
      assert place.lat == 120.5
      assert place.lng == 120.5
      assert place.name == "some name"
      assert place.villages == "some villages"
    end

    test "create_place/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_place(@invalid_attrs)
    end

    test "update_place/2 with valid data updates the place" do
      place = place_fixture()
      assert {:ok, %Place{} = place} = Locations.update_place(place, @update_attrs)
      assert place.address == "some updated address"
      assert place.area == "some updated area"
      assert place.gcode == 43
      assert place.lat == 456.7
      assert place.lng == 456.7
      assert place.name == "some updated name"
      assert place.villages == "some updated villages"
    end

    test "update_place/2 with invalid data returns error changeset" do
      place = place_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_place(place, @invalid_attrs)
      assert place == Locations.get_place!(place.id)
    end

    test "delete_place/1 deletes the place" do
      place = place_fixture()
      assert {:ok, %Place{}} = Locations.delete_place(place)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_place!(place.id) end
    end

    test "change_place/1 returns a place changeset" do
      place = place_fixture()
      assert %Ecto.Changeset{} = Locations.change_place(place)
    end
  end
end
