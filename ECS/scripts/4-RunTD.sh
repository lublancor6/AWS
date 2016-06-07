if [ $(whoami) = root ];
then
	aws ecs run-task --cluster default --task-definition task-${GEPID}:1
else
	sudo aws ecs run-task --cluster default --task-definition task-${GEPID}:1
fi
