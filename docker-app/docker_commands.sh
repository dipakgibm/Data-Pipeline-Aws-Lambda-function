# delete the docker image ghactivity-aws
docker rm ghactivity-aws -f

# stop the container 
docker stop ghactivity-aws

# remove the container
docker rm ghactivity-aws
#build images
docker build -t ghactivity-aws .

#create container
docker run --name ghactivity-aws -d ghactivity-aws

# add the volums
docker run \
     -p 9080:8080\
    --name ghactivity-aws \
     -e BUCKET_NAME=aigithubs \
     -e FOLDER=landing/ghactivity\
     -e TARGET_FOLDER=raw/ghactivity\
     -d \
     ghactivity-aws

# copy the aws file to container 
docker cp /mnt/c/Users/dipak/.aws ghactivity-aws:/root
# open the container in interactive mode

docker exec -it ghactivity-aws bash |python -c"import app;app.lambda_ingest(None,None)"
# display the container name
python -c"import app;app.lambda_ingest(None,None)"
# aws s3 ls s3://aigithubs/landing/ghactivity --recursive

# docker ps -a | grep ghactivity

#calling the lambda function locally
curl -XPOST \
 "http://localhost:9080/2015-03-31/functions/function/invocations" \
 -d '{"jobRunDetails":{"last_run_file_name":"2023-09-02-0.json.gz"}}'

 # check the logs in docker container
 docker logs -f ghactivity-aws

 #ECR

 aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 130663382464.dkr.ecr.us-east-1.amazonaws.com

 docker build -t ghactivity-aws .

 docker tag ghactivity-aws:latest 130663382464.dkr.ecr.us-east-1.amazonaws.com/ghactivity-aws:latest
 docker push 130663382464.dkr.ecr.us-east-1.amazonaws.com/ghactivity-aws:latest