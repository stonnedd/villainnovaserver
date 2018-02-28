Postgrex.Types.define(Autocar.PostgresTypes,
                [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
                json: Poison)