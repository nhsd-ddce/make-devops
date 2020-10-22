slack-it: ### Send Jenkins pipeline notification - mandatory: PIPELINE_NAME,BUILD_STATUS,SLACK_WEBHOOK_URL
	now=$(shell date -u +"%Y%m%d%H59%S")
	make slack-send-standard-notification \
		NAME=jenkins-pipeline-$(shell echo $(BUILD_STATUS) | tr '[:upper:]' '[:lower:]') \
		BUILD_STATUS=$(shell echo $(BUILD_STATUS) | awk '{print toupper(substr($$0,0,1))tolower(substr($$0,2))}') \
		BUILD_TIME=$$(( $$(( $$now - $(BUILD_TIMESTAMP) )) / 60 ))m$$(( $$(( $$now - $(BUILD_TIMESTAMP) )) % 60 ))s

slack-send-standard-notification: ### Send standard notification - mandatory: NAME=[notification template name],SLACK_WEBHOOK_URL
	make slack-send-notification FILE=$(LIB_DIR)/slack/$(NAME).json

slack-send-notification: ### Send notification based on a template - mandatory: FILE=[template file],SLACK_WEBHOOK_URL
	message=$$(make slack-render-template FILE=$(FILE))
	curl --request POST --header "Content-type: application/json" --data "$$message" $(SLACK_WEBHOOK_URL)

slack-render-template: ### Render message content from a template - mandatory: FILE=[template file]
	file=$(TMP_DIR_REL)/$(@)_$(BUILD_ID)
	make -s file-copy-and-replace SRC=$(FILE) DEST=$$file >&2 && trap "rm -f $$file" EXIT
	cat $$file | sed "s;SLACK_EXTRA_DETAILS_TO_REPLACE;;g"

.SILENT: \
	slack-render-template
