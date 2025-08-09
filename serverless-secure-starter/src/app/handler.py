import json, os

def lambda_handler(event, context):
    name = (event.get("queryStringParameters") or {}).get("name","world")
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"message": f"hello, {name}", "env": os.environ.get("STAGE","dev")})
    }