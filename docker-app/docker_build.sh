 docker rmi 130663382464.dkr.ecr.us-east-1.amazonaws.com/ghactivity-aws:latest
 
 docker rmi ghactivity-aws

 aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 130663382464.dkr.ecr.us-east-1.amazonaws.com

 docker build -t ghactivity-aws .

 docker tag ghactivity-aws:latest 130663382464.dkr.ecr.us-east-1.amazonaws.com/ghactivity-aws:latest
 docker push 130663382464.dkr.ecr.us-east-1.amazonaws.com/ghactivity-aws:latest

 # get aws ecr images info
 aws ecr list-images --repository-name ghactivity-aws 
 # get lambda function details

 aws lambda get-function --function-name dockerlambda

 # aws lambda get config details
 aws lambda get-function-configuration --function-name dockerlambda

# update the labmda function code
aws lambda update-function-code \
    --function-name dockerlambda \
    --image-url 130663382464.dkr.ecr.us-east-1.amazonaws.com/ghactivity-aws:latest