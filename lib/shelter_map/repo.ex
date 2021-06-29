defmodule ShelterMap.Repo do
  use Ecto.Repo,
    otp_app: :shelter_map,
    adapter: Ecto.Adapters.Postgres
end
