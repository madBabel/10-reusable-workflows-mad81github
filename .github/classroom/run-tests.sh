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

echo "Espera un momento para que el flujo termine su ejecución..."
sleep 30

# Test 4: Verificar la salida
echo "Verificando el log del flujo de trabajo..."
OUTPUT=$(gh run list --limit 1 --json conclusion -q '.[0].conclusion')

if [[ "$OUTPUT" == "success" ]]; then
  echo "El flujo de trabajo se ejecutó correctamente."
else
  echo "El flujo de trabajo falló. Revisa los logs en la interfaz de GitHub Actions."
  exit 1
fi
