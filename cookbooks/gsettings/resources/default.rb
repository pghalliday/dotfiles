actions :set
default_action :set

attribute :schema, name_attribute: true, kind_of: String
attribute :key, kind_of: String
attribute :value, kind_of: [String, Array]
attribute :user, kind_of: String
