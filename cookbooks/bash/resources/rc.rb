actions :add
default_action :add

attribute :name, name_attribute: true, kind_of: String
attribute :cookbook, kind_of: String
attribute :source, kind_of: String
attribute :remote_file, kind_of: String
attribute :checksum, kind_of: String
attribute :user, kind_of: String
