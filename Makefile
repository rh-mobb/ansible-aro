.DEFAULT_GOAL := help
.PHONY: help virtualenv kind image deploy

VIRTUALENV ?= "./virtualenv/"
ANSIBLE = $(VIRTUALENV)/bin/ansible-playbook

help:
	@echo GLHF

virtualenv:
	LC_ALL=en_US.UTF-8 python3 -m venv $(VIRTUALENV)
	. $(VIRTUALENV)/bin/activate
	pip install pip --upgrade
	LC_ALL=en_US.UTF-8 ./virtualenv/bin/pip3 install -r requirements.txt
	./virtualenv/bin/ansible-galaxy collection install azure.azcollection --force
	./virtualenv/bin/pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
	./virtualenv/bin/ansible-galaxy collection install community.okd

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
	$(ANSIBLE) -v create-cluster.yaml

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
