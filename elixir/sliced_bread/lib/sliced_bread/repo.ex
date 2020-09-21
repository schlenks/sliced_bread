defmodule SlicedBread.Repo do
  use Ecto.Repo,
    otp_app: :sliced_bread,
    adapter: Ecto.Adapters.Postgres
end
