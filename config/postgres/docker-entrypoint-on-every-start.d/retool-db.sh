#!/bin/bash

set -e

LAST_HASH=$(psql -XtAq -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE TABLE IF NOT EXISTS public.migrations
	(
		name text COLLATE pg_catalog."default" NOT NULL,
		value text COLLATE pg_catalog."default" NOT NULL,
		CONSTRAINT migrations_pkey PRIMARY KEY (name)
	);

	SELECT value FROM public.migrations WHERE name = 'retool';
EOSQL
)

CURRENT_HASH=$(md5sum /backups/retool.sql | awk '{ print $1 }')

echo "Last hash: $LAST_HASH"
echo "Current hash: $CURRENT_HASH"

if [ "$LAST_HASH" = "$CURRENT_HASH" ]
then
    echo "Hashes are the same. Skipping database refresh..."
else
    echo "Hashes are different. Recreating database and restoring fresh backup..."

	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    DROP DATABASE IF EXISTS retool;
		CREATE DATABASE retool;
	EOSQL

  echo "Successfully recreated database"

	psql -v ON_ERROR_STOP=1 -d retool < "/backups/retool.sql"

	echo "Successfully reshreshed database"

	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    INSERT INTO public.migrations (name, value)
    VALUES('retool','$CURRENT_HASH') 
    ON CONFLICT (name) 
    DO 
      UPDATE SET value = '$CURRENT_HASH';
	EOSQL

	echo "Successfully refreshed the hash"
fi
