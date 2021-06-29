defmodule ShelterMap.Locations.Place do
  use Ecto.Schema
  import Ecto.Changeset

  schema "place" do
    field :address, :string
    field :area, :string
    field :gcode, :integer
    field :lat, :float
    field :lng, :float
    field :name, :string
    field :villages, :string

    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:name, :lat, :lng, :gcode, :area, :address, :villages])
    |> validate_required([:name, :lat, :lng, :gcode, :area, :address, :villages])
  end
end
