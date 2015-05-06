actions :add
default_action :add

attribute :package, name_attribute: true, kind_of: String
attribute :creates, kind_of: String
attribute :android_home, kind_of: String
