defmodule ShelterMapWeb.PlaceController do
  use ShelterMapWeb, :controller

  alias ShelterMap.Locations
  alias ShelterMap.Locations.Place

  def index(conn, _params) do
    place = Locations.list_place()
    render(conn, "index.html", place: place)
  end

  def new(conn, _params) do
    changeset = Locations.change_place(%Place{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"place" => place_params}) do
    case Locations.create_place(place_params) do
      {:ok, place} ->
        conn
        |> put_flash(:info, "Place created successfully.")
        |> redirect(to: Routes.place_path(conn, :show, place))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def createList(conn,%{"list" => list}) do
    for place <- list do
      case Locations.create_place(place) do
        {:ok, place} ->
          conn
          |> put_flash(:info, "Place created successfully.")
      end
    end
    redirect(conn,to: Routes.place_path(conn, :index)) 
  end

  def show(conn, %{"id" => id}) do
    place = Locations.get_place!(id)
    render(conn, "show.html", place: place)
  end

  def edit(conn, %{"id" => id}) do
    place = Locations.get_place!(id)
    changeset = Locations.change_place(place)
    render(conn, "edit.html", place: place, changeset: changeset)
  end

  def update(conn, %{"id" => id, "place" => place_params}) do
    place = Locations.get_place!(id)

    case Locations.update_place(place, place_params) do
      {:ok, place} ->
        conn
        |> put_flash(:info, "Place updated successfully.")
        |> redirect(to: Routes.place_path(conn, :show, place))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", place: place, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    place = Locations.get_place!(id)
    {:ok, _place} = Locations.delete_place(place)

    conn
    |> put_flash(:info, "Place deleted successfully.")
    |> redirect(to: Routes.place_path(conn, :index))
  end

  def deleteAll(conn,_params) do
    places = Locations.list_place()
    for place <- places do
    {:ok, _place} = Locations.delete_place(place)
    end
    conn
    |> put_flash(:info, "Place deleted successfully.")
    |> redirect(to: Routes.place_path(conn, :index))
  end


  def newFile(conn,_params) do
    render(conn, "new_file.html")
  end

  def createFile(conn, %{"file" => file}) do
    new_list = Locations.create_fromCSV(file.path)
    Enum.each(new_list, fn place -> 
      place_params = %{name: place["\uFEFF避難所_名称"], lat: place["緯度"], lng: place["経度"], gcode: place["地方公共団体コード"], area: place["都道府県"], villages: place["指定区市町村名"], address: place["住所"]}
      Locations.create_place(place_params)
    end)
    places = Locations.list_place()
    redirect(conn, to: Routes.page_path(conn,:index)) 
  end




end
