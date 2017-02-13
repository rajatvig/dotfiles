function aws_init
  set -l out_file "/tmp/tmp.json"

  switch $argv[1]
    case dev
      set -gx _account_id $AWS_DEV_ACCOUNT
    case staging
      set -gx _account_id $AWS_STG_ACCOUNT
    case prod
      set -gx _account_id $AWS_PRD_ACCOUNT
  end

  aws sts assume-role --role-arn "arn:aws:iam::$_account_id:role/$AWS_ROLE_SUFFIX" --role-session-name "aws-$argv[1]" > $out_file

  set -gx AWS_SECRET_ACCESS_KEY (cat $out_file | jq --raw-output '.Credentials.SecretAccessKey')
  set -gx AWS_ACCESS_KEY_ID (cat $out_file | jq --raw-output '.Credentials.AccessKeyId')
  set -gx AWS_SESSION_TOKEN (cat $out_file | jq --raw-output '.Credentials.SessionToken')

  rm $out_file
end
