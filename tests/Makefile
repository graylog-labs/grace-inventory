environment := integration-testing
export appenv := $(shell echo "$(environment)" | tr '[:upper:]' '[:lower:]')
export TF_VAR_appenv := $(appenv)
undefine TF_VAR_master_account_id
undefine TF_VAR_master_role_name
export backend_key := grace_integration_testing_inventory_lambda.tfstate

.PHONY: apply plan validate init destroy test

destroy: init
	terraform destroy -auto-approve

test: init 
	apk add --no-cache python3-dev gcc libressl-dev musl-dev libffi-dev
	pip3 install --upgrade pip setuptools flask "moto[server]"
	go test -v ./...

apply: plan
	terraform apply -auto-approve

plan: validate
	terraform plan

validate: init
	terraform validate
	terrascan --location . --tests all

init: create_files
	terraform init

create_files:
	[[ -d ../release ]] || mkdir ../release
	[[ -e ../release/grace-inventory-lambda.zip ]] || touch ../release/grace-inventory-lambda.zip
