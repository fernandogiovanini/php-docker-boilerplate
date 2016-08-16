#!/bin/bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

# We might run into trouble when using the default `postgres` user, e.g. when dropping the postgres
# database in restore.sh. Check that something else is used here
if [ "$POSTGRES_USER" == "postgres" ]
then
    echo " > Restoring as the Postgres user is not supported, make sure to set the POSTGRES_USER environment variable"
    exit 1
fi

# Export the postgres password so that subsequent commands don't ask for it
export PGPASSWORD=$POSTGRES_PASSWORD

# Delete the db
# Deleting the db can fail. Spit out a comment if this happens but continue since the db
# is created in the next step
echo " > Deleting old database $POSTGRES_USER"
if dropdb -U $POSTGRES_USER $POSTGRES_USER
then
    echo " > Deleted $POSTGRES_USER database"
else
    echo " > Database $POSTGRES_USER does not exist, continue"
fi

# Create a new database
echo " > Creating new database $POSTGRES_USER"
createdb -U $POSTGRES_USER $POSTGRES_USER -O $POSTGRES_USER

# Restore the database
echo " > Restoring database $POSTGRES_USER"
echo "$1" | psql -U $POSTGRES_USER