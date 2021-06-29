defmodule ShelterMapWeb.PageController do
  use ShelterMapWeb, :controller
  alias ShelterMap.Locations

  def index(conn, _params) do
    place = Locations.list_place()
    render(conn, "index.html", place: place)
  end

  def showArea(conn,%{"villages" => village}) do
    if village == "" do
      redirect(conn,to: Routes.page_path(conn,:index))
    else
      place = Locations.get_place_by_village(village)
      render(conn,"show_area.html",place: place)
    end
  end
end
