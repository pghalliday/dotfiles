actions :add
default_action :add

attribute :user, name_attribute: true, kind_of: String
attribute :aws_s3_bucket, kind_of: String
attribute :aws_access_key_id, kind_of: String
attribute :aws_secret_access_key, kind_of: String
