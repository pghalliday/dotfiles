actions :set
default_action :set

attribute :property, name_attribute: true, kind_of: String
attribute :user, kind_of: String
attribute :project_path, kind_of: String
attribute :value, kind_of: String
