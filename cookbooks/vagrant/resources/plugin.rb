actions :install
default_action :install

attribute :name, name_attribute: true, kind_of: String
attribute :user, kind_of: String
attribute :license, kind_of: String
