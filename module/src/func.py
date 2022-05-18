import boto3
import os


def lambda_handler(event, context):
    print("EVENT", event)
    message = event['detail']
    ec2 = boto3.resource("ec2", region_name="us-east-1")
    asgClient = boto3.client('autoscaling')
    lifeCycleHook = message['LifecycleHookName']
    autoScalingGroup = message['AutoScalingGroupName']
    instance = ec2.Instance(event['detail']['EC2InstanceId'])
    instanceId = str(message['EC2InstanceId'])
    volumes = instance.volumes.all()
    print("EVENT", event)
    print("INSTANCE ID", event['detail']['EC2InstanceId'])
    print("VOLUMES", volumes)
    for vol in instance.volumes.all():
        if vol.attachments[0][u'Device'] == '/dev/sdb':
            volume = ec2.Volume(vol.id)
            ec2.create_snapshot(
                VolumeId=vol.id, Description="Snapshot from volume")
            volume.detach_from_instance(
                Device='/dev/sdb',
                InstanceId=event['detail']['EC2InstanceId']
            )
            volume.delete()
            asgClient = boto3.client('autoscaling')
            lifeCycleHook = message['LifecycleHookName']
            autoScalingGroup = message['AutoScalingGroupName']

            response = asgClient.complete_lifecycle_action(
                LifecycleHookName=lifeCycleHook,
                AutoScalingGroupName=autoScalingGroup,
                LifecycleActionResult="CONTINUE",
                InstanceId=instanceId
            )
    return None
