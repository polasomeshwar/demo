POD_NAME="secret-app-vault-0" 

kubectl exec $POD_NAME -n vault -- vault operator init -key-shares=1 -key-threshold=1 -format=json > keys.json


VAULT_UNSEAL_KEY=$(cat keys.json | jq -r ".unseal_keys_b64[]")

echo $VAULT_UNSEAL_KEY

VAULT_ROOT_KEY=$(cat keys.json | jq -r ".root_token")

echo $VAULT_ROOT_KEY

kubectl exec $POD_NAME -n vault -- vault operator unseal $VAULT_UNSEAL_KEY
