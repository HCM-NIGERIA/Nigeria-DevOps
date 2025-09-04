import boto3
rds = boto3.client('rds')

def lambda_handler(event, context):

    #Stop DB instances
    dbs = rds.describe_db_instances()
    for db in dbs['DBInstances']:
        #Check if DB instance is not already stopped
        if (db['DBInstanceStatus'] == 'available'):
            try:
                GetTags=rds.list_tags_for_resource(ResourceName=db['DBInstanceArn'])['TagList']
                for tags in GetTags:
                #if tag "autostop=yes" is set for instance, stop it
                    if(tags['Key'] == 'AutoStop' and tags['Value'] == 'true'):
                        result = rds.stop_db_instance(DBInstanceIdentifier=db['DBInstanceIdentifier'])
                        print ("Stopping instance: {0}.".format(db['DBInstanceIdentifier']))
            except Exception as e:
                print ("Cannot stop instance {0}.".format(db['DBInstanceIdentifier']))
                print(e)
                
if __name__ == "__main__":
    lambda_handler(None, None)