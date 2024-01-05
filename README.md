# PG Monitoring Stack

`pg-monitoring-stack` can launch PostgreSQL, PGbouncer, exporters, Prometheus and Grafana all in once and fully-integrated.

## Services

- `postgres`: This service uses the `postgres:13-alpine` image and is configured with a custom configuration file.
- `postgres-exporter`: This service uses the `prometheuscommunity/postgres-exporter:v0.15.0` image and is configured to collect various metrics from the Postgres service.
- `pgbouncer`: This service uses the `edoburu/pgbouncer` image and is configured to pool Postgres connections.
- `pgbouncer-exporter`: This service uses the `prometheuscommunity/pgbouncer-exporter:v0.7.0` image and is configured to collect metrics from the PgBouncer service.
- `query-exporter`: This service uses the `adonato/query-exporter:2.9.2` image and is configured to run queries against the Postgres service and export the results as Prometheus metrics.
- `grafana`: This service uses the `grafana/grafana` image and is used for visualizing the metrics collected by the other services.
- `prometheus`: This service uses the `prom/prometheus` image and is configured to collect metrics from the other services.

## Usage

To start all services, run:

```bash
docker-compose up -d
```

To stop all services, run:

```bash
docker-compose down
```

## Accessing the services

Once the services are up and running, they can be accessed at the following ports:

- `postgres`: 5432
- `postgres-exporter`: 9187
- `pgbouncer`: 5432
- `pgbouncer-exporter`: 9127
- `query-exporter`: 9560
- `grafana`: 3000
- `prometheus`: 9090

Please note that you might need to adjust the firewall settings of your machine to allow traffic to these ports.

## Data persistence

The `postgres`, `grafana`, and `prometheus` services persist their data in the `pg-data`, `gf-data`, and `prom-data` directories respectively. These directories are created in the same location as the `docker-compose.yml` file when the services are started for the first time.

The `gf-data` directory is particularly important as it preserves the pre-defined dashboard settings in Grafana. Deleting this directory will result in the loss of these settings.

To delete the data and start from scratch, you can delete the `pg-data` and `prom-data` directories. Please note that this will delete all your data and cannot be undone. It is recommended to keep the `gf-data` directory unless you want to reset the Grafana dashboard settings.
