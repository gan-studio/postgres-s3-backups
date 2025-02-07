# Build a container that takes pg_dump and uploads to s3

The push_to_ecr script builds a docker container that takes a dump of a POSTGRESQL instance, zips it, and uploads it to s3.

The container needs 3 environment variables: 
1. S3_BUCKET_NAME - the bucket where we upload the backup to
2. AWS_REGION - the region of the bucket
3. DATABASE_URL - the complete url of the database of the form (postgres://username:password@host-address/database)


