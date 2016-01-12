#! /bin/sh

USER="SSH_USER"
HOST="HOST_NAME"
RATE="1000"

FROM_DIR="/home/web/database/"
DEST_DIR="/home/web/backup/"
TIMESTAMP="date +%Y.%m.%d-"

cd "$DEST_DIR"

echo "Copying latest databases backup"
scp -l"$RATE" "$USER@$HOST:$DB_DIR"`$TIMESTAMP`"*" db/

echo "Copying latest content images backup"
scp -l"$RATE" "$USER@$HOST:$IMG_DIR"`$TIMESTAMP`"*" img/
