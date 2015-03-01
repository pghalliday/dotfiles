use_inline_resources

def whyrun_supported?
  true
end

action :create do
  s3file = S3UrlGenerator.new(new_resource.bucket, new_resource.remote_path, new_resource.aws_access_key_id, new_resource.aws_secret_access_key)
  remote_file new_resource.path do
    source s3file.url
    headers s3file.headers
    checksum new_resource.checksum
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end
end
