if [ $(whoami) = root ];
then
	aws ecs describe-task-definition --task-definition task-${GEPID}:1
else
	sudo aws ecs describe-task-definition --task-definition task-${GEPID}:1
fi
