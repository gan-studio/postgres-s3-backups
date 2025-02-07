#!/bin/bash

AWS_REGION="ap-south-1"  
AWS_ACCOUNT_ID="347345745078"
# AWS_ACCOUNT_ID="347345745078"
ECR_REPOSITORY="db_backup_cron_dev_repo"  

curr_date=$(date)
curr_date=${curr_date// /_}
curr_date=${curr_date//:/-}


IMAGE_NAME="${ECR_REPOSITORY}:latest"
IMAGE_NAME_WITH_DATE="${ECR_REPOSITORY}:${curr_date}"


sudo docker buildx build --platform linux/amd64 --build-arg POSTGRES_VERSION=16 -t $IMAGE_NAME -f Dockerfile .


aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
IMAGE_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/${IMAGE_NAME}"
IMAGE_URI_WITH_DATE="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/${IMAGE_NAME_WITH_DATE}"

docker tag $IMAGE_NAME $IMAGE_URI
docker tag $IMAGE_NAME $IMAGE_URI_WITH_DATE

echo "Pushing image to $IMAGE_URI"
docker push $IMAGE_URI

echo "Pushing image to $IMAGE_URI_WITH_DATE"
docker push $IMAGE_URI_WITH_DATE

