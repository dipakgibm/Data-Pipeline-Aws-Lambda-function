FROM public.ecr.aws/lambda/python:3.9

COPY requirement.txt requirement.txt
RUN pip install -r requirement.txt

COPY app ${LAMBDA_TASK_ROOT}/app
ENV PYTHONPATH=${LAMBDA_TASK_ROOT}/app

CMD [ "app.lambda_transform" ]
