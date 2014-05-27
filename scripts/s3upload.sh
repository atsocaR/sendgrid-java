#!/bin/bash

# From:
# http://raamdev.com/2008/using-curl-to-upload-files-via-post-to-amazon-s3/

GIT_VERSION=`git rev-parse --short HEAD`

curl -X POST \
  -F "key=sendgrid-java/versions/sendgrid-java-$GIT_VERSION.jar" \
  -F "acl=public-read" \
  -F "AWSAccessKeyId=$S3_ACCESS_KEY" \
  -F "Policy=$S3_POLICY" \
  -F "Signature=$S3_SIGNATURE" \
  -F "Content-Type=application/zip" \
  -F "file=@./repo/com/sendgrid/sendgrid-jar.jar" \
  https://s3.amazonaws.com/$S3_BUCKET

if [ "$TRAVIS_BRANCH" = "master" ]
then 
  curl -X POST \
    -F "key=sendgrid-java/sendgrid-java.jar" \
    -F "acl=public-read" \
    -F "AWSAccessKeyId=$S3_ACCESS_KEY" \
    -F "Policy=$S3_POLICY" \
    -F "Signature=$S3_SIGNATURE" \
    -F "Content-Type=application/zip" \
    -F "file=@./repo/com/sendgrid/sendgrid-jar.jar" \
    https://s3.amazonaws.com/$S3_BUCKET
fi

exit 0
