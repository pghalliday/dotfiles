actions :add
default_action :add

attribute :directory, name_attribute: true, kind_of: String
attribute :user, kind_of: String
attribute :cookbook, kind_of: String
attribute :tmuxomatic, kind_of: String
attribute :repository, kind_of: String
attribute :email, kind_of: String
