-- IAM access key created (investigate automation vs human)
SELECT userIdentity.arn, eventTime, sourceIPAddress
FROM cloudtrail_logs
WHERE eventName = 'CreateAccessKey';

-- S3 bucket made public (example; depends on logs schema)
SELECT eventTime, requestParameters.bucketName
FROM cloudtrail_logs
WHERE eventName IN ('PutBucketAcl','PutBucketPolicy')
  AND requestParameters.acl LIKE '%public%';