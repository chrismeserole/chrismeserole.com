#!/bin/sh

export EC2_ACCESS_KEY=$AWS_ACCESS_KEY_ID
export EC2_SECRET_KEY=$AWS_SECRET_KEY_ID
export AWS_GDELT_BUCKET=${1}
export LOCAL_DIRECTORY=${2}

# Install/config AWS upload script:

if [ ! -f "aws" ]; then
  curl https://raw.github.com/timkay/aws/master/aws -o aws
  chmod +x aws
  perl aws --install
fi

if [[ $LOCAL_DIRECTORY == *\** ]]
then
    for file in *; do
    if [[ "$file" != *.sh* && "$file" != *aws* ]]
      then
      s3put $AWS_GDELT_BUCKET $file
      echo "$file";
    fi
    done
elif [ -d "$LOCAL_DIRECTORY" ]; then
    for file in $LOCAL_DIRECTORY*; do
              echo "uploading $file"
              s3put $AWS_GDELT_BUCKET $file
    done
else
  echo "Local directory doesn't exist."
fi
