import json, boto3, os

iam = boto3.client('iam')

def handler(event, context):
    # Expect event with keys: user_name, access_key_id
    print(json.dumps(event))
    user = event.get('user_name')
    key  = event.get('access_key_id')
    if not user or not key:
        return {"ok": False, "reason": "missing fields"}
    iam.update_access_key(UserName=user, AccessKeyId=key, Status='Inactive')
    return {"ok": True, "disabled": key, "user": user}