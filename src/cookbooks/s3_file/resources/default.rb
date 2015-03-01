default_action :create
actions :create

attribute :path, kind_of: String, name_attribute: true
attribute :remote_path, kind_of: String, required: true
attribute :bucket, kind_of: String, required: true
attribute :aws_access_key_id, kind_of: String, required: true
attribute :aws_secret_access_key, kind_of: String, required: true
attribute :owner, regex: Chef::Config[:user_valid_regex], default: nil
attribute :group, regex: Chef::Config[:group_valid_regex], default: nil
attribute :mode, kind_of: [Integer, String], default: nil
attribute :checksum, kind_of: [String], default: nil
