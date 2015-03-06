actions :add
default_action :add

attribute :name, name_attribute: true, kind_of: String
attribute :command, kind_of: String
attribute :user, kind_of: String
attribute :subshell, kind_of: [TrueClass, FalseClass], default: false
attribute :arg_offset, kind_of: Integer, default: 0
attribute :force_system_command, kind_of: [TrueClass, FalseClass], default: false
