actions :add
default_action :add

attribute :host, name_attribute: true, kind_of: String
attribute :user, kind_of: String
attribute :fingerprint, kind_of: String
