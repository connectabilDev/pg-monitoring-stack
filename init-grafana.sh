#!/bin/bash

sudo chown -R 472:472 ./gf-data

# Nome do volume Docker para o Grafana
VOLUME_NAME="grafana_data"

# Caminho local dos dados existentes
DATA_SOURCE="./gf-data"

# Verifica se o volume já existe
volume=$(docker volume ls -q | grep "^${VOLUME_NAME}$")
if [ -z "$volume" ]; then
  echo "Criando volume Docker: $VOLUME_NAME"
  docker volume create "$VOLUME_NAME"

  # Copia os dados para o novo volume, utilizando um contêiner temporário
  echo "Copiando dados para o volume $VOLUME_NAME..."
  docker run --rm -v "${VOLUME_NAME}:/volume" -v "$(pwd)/${DATA_SOURCE}:/backup" alpine cp -a /backup/. /volume/
else
  echo "Volume $VOLUME_NAME já existe, pulando a etapa de cópia de dados."
fi

# Inicializa o docker-compose
echo "Inicializando o Grafana com docker-compose..."
docker-compose up -d
