#!/bin/bash

# Test 1: Verificar la existencia de los archivos
if [ ! -f ".github/workflows/18-1-reusable-workflow.yaml" ]; then
  echo "Error: Archivo 18-1-reusable-workflow.yaml no existe."
  exit 1
fi

if [ ! -f ".github/workflows/18-2-reusable-workflow.yaml" ]; then
  echo "Error: Archivo 18-2-reusable-workflow.yaml no existe."
  exit 1
fi

# Test 2: Validar sintaxis YAML
echo "Validando sintaxis YAML..."
yamllint .github/workflows/18-1-reusable-workflow.yaml
yamllint .github/workflows/18-2-reusable-workflow.yaml

# Test 3: Desencadenar el flujo manualmente y verificar salida
echo "Desencadenando el flujo de trabajo 18-2..."
gh workflow run "18 - 2 - Reusable Workflows" || {
  echo "Error al intentar desencadenar el flujo 18-2-reusable-workflow.yaml."
  exit 1
}
