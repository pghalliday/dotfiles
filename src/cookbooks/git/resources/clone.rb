actions :add
default_action :add

attribute :repository, name_attribute: true, kind_of: String
attribute :user, kind_of: String
attribute :project_path, kind_of: String
