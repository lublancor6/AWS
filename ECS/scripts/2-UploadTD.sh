#!/bin/bash
if [ $(whoami) = root ];
then
	aws ecs register-task-definition --cli-input-json file:///tmp/${GEPID}.json
else
	sudo aws ecs register-task-definition --cli-input-json file:///tmp/${GEPID}.json

fi
