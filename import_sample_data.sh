#!/usr/bin/env bash
set -euo pipefail

COMPOSE=${COMPOSE_BIN:-docker compose}
DB_SERVICE=${DB_SERVICE:-postgres}
DB_USER=${DB_USER:-library}
DB_NAME=${DB_NAME:-librarydb}

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

SCHEMA_FILE=${SCHEMA_FILE:-script.sql}
DATA_FILE=${DATA_FILE:-sample_data.sql}

if [[ ! -f "${ROOT_DIR}/${SCHEMA_FILE}" ]]; then
  echo "Schema file '${SCHEMA_FILE}' not found in ${ROOT_DIR}" >&2
  exit 1
fi

if [[ ! -f "${ROOT_DIR}/${DATA_FILE}" ]]; then
  echo "Data file '${DATA_FILE}' not found in ${ROOT_DIR}" >&2
  exit 1
fi

echo "[1/2] Applying schema from ${SCHEMA_FILE}..."
${COMPOSE} exec -T ${DB_SERVICE} psql -U ${DB_USER} -d ${DB_NAME} < "${ROOT_DIR}/${SCHEMA_FILE}"

echo "[2/2] Loading sample data from ${DATA_FILE}..."
${COMPOSE} exec -T ${DB_SERVICE} psql -U ${DB_USER} -d ${DB_NAME} < "${ROOT_DIR}/${DATA_FILE}"

echo "Done."
