'''
when creating the trigger make sure to add the file filter in prefix.
'''
import os
import json
import boto3


def lambda_handler(event, context):
    s3_client=boto3.client('s3')
    bucket_name = os.environ.get('BUCKET_NAME')
    file_key = event['Records'][0]['s3']['object']['key']
    print('reading the files....')
    body = s3_client.get_object(Bucket=bucket_name,Key=file_key)['Body']
    json_records= []
    for rec in body.read().decode('utf-8').splitlines():
        rec_details =rec.split(',')
        json_record = json.dumps({
            'order_id':rec_details[0],
            'order_date':rec_details[1],
            'order_customer_id':rec_details[2],
            'order_status':rec_details[3]
      })
        json_records.append(json_record)
    print('Uploading the file to s3 bucket')
    json_docs='\n'.join(json_record)
    s3_client.put_object(
     Bucket=bucket_name,
     Key='retail_json/order.json',
     Body=json_docs.encode('utf-8')
     )
     
    return {
        'statusCode': 200,
         'body': event

    }
