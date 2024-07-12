.DEFAULT_GOAL := help

CLUSTER_NAME ?= ans-$(shell whoami)
RESOURCE_GROUP ?= ans-$(shell whoami)-rg
EXTRA_VARS ?= --extra-vars "azr_aro_cluster=$(CLUSTER_NAME) azr_resource_group=$(RESOURCE_GROUP)"

VIRTUALENV ?= "./virtualenv/"
ANSIBLE = $(VIRTUALENV)/bin/ansible-playbook $(EXTRA_VARS)

.PHONY: help
help:
	@echo GLHF

.PHONY: virtualenv
virtualenv:
	LC_ALL=en_US.UTF-8 python3 -m venv $(VIRTUALENV)
	. $(VIRTUALENV)/bin/activate
	$(VIRTUALENV)/bin/pip3 install pip --upgrade
	LC_ALL=en_US.UTF-8 $(VIRTUALENV)/bin/pip3 install -r requirements.txt
	$(VIRTUALENV)/bin/ansible-galaxy collection install azure.azcollection --force
	$(VIRTUALENV)/bin/pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt
	$(VIRTUALENV)/bin/ansible-galaxy collection install community.okd

.PHONY: help

# docker.image:
# 	docker build -t quay.io/pczar/ansible-rosa .

# docker.image.push:
# 	docker push quay.io/pczar/ansible-rosa

# docker.image.pull:
# 	docker pull quay.io/pczar/ansible-rosa

# # docker shortcuts
# build: docker.image
# image: docker.image
# push: docker.image.push
# pull: docker.image.pull


create:
	$(ANSIBLE) -vvvv create-cluster.yaml

delete:
	$(ANSIBLE) -v delete-cluster.yaml

create.private:
	$(ANSIBLE) -v create-cluster.yaml -i ./environment/private/hosts

delete.private:
	$(ANSIBLE) -v delete-cluster.yaml -i ./environment/private/hosts

create.mobb-infra-aro:
	$(ANSIBLE) -v create-cluster.yaml -i ../mobb-infra/aro/hosts

pull-secret:
	$(ANSIBLE) -v pull-secret.yaml

# docker.create: image
# 	docker run --rm \
# 		-v $(HOME)/.ocm.json:/home/ansible/.ocm.json \
# 		-v $(HOME)/.aws:/home/ansible/.aws \
# 	  -ti quay.io/pczar/ansible-rosa \
# 		$(ANSIBLE) -v create-cluster.yaml

# docker.delete: image
# 	docker run --rm \
# 		-v $(HOME)/.ocm.json:/home/ansible/.ocm.json \
# 		-v $(HOME)/.aws:/home/ansible/.aws \
# 	  -ti quay.io/pczar/ansible-rosa \
# 		$(ANSIBLE) -v delete-cluster.yaml
