defmodule ShelterMap.Repo.Migrations.CreatePlace do
  use Ecto.Migration

  def change do
    create table(:place) do
      add :name, :string
      add :lat, :float
      add :lng, :float
      add :gcode, :integer
      add :area, :string
      add :address, :string
      add :villages, :string

      timestamps()
    end

  end
end
