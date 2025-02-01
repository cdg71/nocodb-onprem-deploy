#!/bin/sh

# Attendre que MinIO soit prêt avec curl
echo "Waiting for MinIO to start..."
while ! curl -s http://localhost:9000 > /dev/null; do
    sleep 1
done
echo "MinIO is ready."

# Configurer le client MinIO (mc)
echo "Configuring MinIO client..."
mc alias set myminio http://localhost:9000 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD
if [ $? -ne 0 ]; then
    echo "Error configuring MinIO client. Check credentials."
    exit 1
fi

# Créer le bucket 'nocodb' s'il n'existe pas
echo "Creating bucket 'nocodb'..."
mc ls myminio/nocodb > /dev/null 2>&1 || mc mb myminio/nocodb
if [ $? -eq 0 ]; then
    echo "Bucket 'nocodb' created successfully."
else
    echo "Error creating bucket 'nocodb'."
    exit 1
fi

# Garder le conteneur actif
tail -f /dev/null
