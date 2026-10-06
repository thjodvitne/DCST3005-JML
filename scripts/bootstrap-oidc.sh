#!/usr/bin/env bash
# Oppretter App Registration UTEN client secret, med federated credential per miljø.
# Kjør én gang lokalt etter `az login`. Skriptet endrer ikke repoet.
set -euo pipefail

: "${GITHUB_ORG:?sett GITHUB_ORG}"
: "${GITHUB_REPO:?sett GITHUB_REPO}"
: "${STATE_RG:?sett STATE_RG (resource group med state-storage)}"
: "${STORAGE_ACCOUNT:?sett STORAGE_ACCOUNT}"
APP_NAME="${APP_NAME:-sp-tf-${GITHUB_REPO}}"
ENVIRONMENTS="${ENVIRONMENTS:-dev test}"

SUB_ID="$(az account show --query id -o tsv)"
SUB_SCOPE="$(printf '/%s/%s' subscriptions "$SUB_ID")"

APP_ID="$(az ad app create --display-name "$APP_NAME" --query appId -o tsv)"
az ad sp create --id "$APP_ID" >/dev/null

for env in $ENVIRONMENTS; do
  az ad app federated-credential create --id "$APP_ID" --parameters "{
    \"name\": \"github-${env}\",
    \"issuer\": \"https://token.actions.githubusercontent.com\",
    \"subject\": \"repo:${GITHUB_ORG}/${GITHUB_REPO}:environment:${env}\",
    \"audiences\": [\"api://AzureADTokenExchange\"]
  }" >/dev/null
done

az role assignment create --assignee "$APP_ID" --role "Contributor" --scope "$SUB_SCOPE" >/dev/null
SA_ID="$(az storage account show -n "$STORAGE_ACCOUNT" -g "$STATE_RG" --query id -o tsv)"
az role assignment create --assignee "$APP_ID" --role "Storage Blob Data Contributor" --scope "$SA_ID" >/dev/null

echo "Ferdig. Legg disse inn som GitHub secrets (ikke i repoet):"
echo "  AZURE_CLIENT_ID       = $APP_ID"
echo "  AZURE_TENANT_ID       = $(az account show --query tenantId -o tsv)"
echo "  AZURE_SUBSCRIPTION_ID = $SUB_ID"
