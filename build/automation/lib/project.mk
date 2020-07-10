project-config: ### Configure project environment
	make \
		git-config \
		docker-config

project-start: ### Start Docker Compose
	make docker-compose-start

project-stop: ### Stop Docker Compose
	make docker-compose-stop

project-log: ### Print log from Docker Compose
	make docker-compose-log

project-deploy: ### Deploy application service stack to the Kubernetes cluster - mandatory: PROFILE=[profile name]
	make k8s-deploy STACK=$(or $(NAME), service)

# ==============================================================================

project-create-profile: ### Create profile file - mandatory: NAME=[profile name]
	cp -fv $(VAR_DIR_REL)/profile/dev.mk.default $(VAR_DIR_REL)/profile/$(NAME).mk

project-create-image: ### Create image from template - mandatory: NAME=[image name],TEMPLATE=[library template image name]
	make -s docker-create-from-template NAME=$(NAME) TEMPLATE=$(TEMPLATE)

project-create-deployment: ### Create deployment from template - mandatory: STACK=[deployment name],PROFILE=[profile name]
	rm -rf $(DEPLOYMENT_DIR)/stacks/$(STACK)
	make -s k8s-create-base-from-template STACK=$(STACK)
	make -s k8s-create-overlay-from-template STACK=$(STACK) PROFILE=$(PROFILE)
	make project-create-profile NAME=$(PROFILE)

project-create-infrastructure: ### Create infrastructure from template - mandatory: STACK=[infrastructure name],TEMPLATE=[library template infrastructure name]
	make -s terraform-create-module-from-template TEMPLATE=$(TEMPLATE)
	make -s terraform-create-stack-from-template NAME=$(STACK) TEMPLATE=$(TEMPLATE)

project-create-pipeline: ### Create pipeline
	make -s jenkins-create-pipeline-from-template

# ==============================================================================

.SILENT: \
	project-create-deployment \
	project-create-image \
	project-create-infrastructure \
	project-create-pipeline \
	project-create-profile
