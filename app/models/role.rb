class Role < ActiveRecord::Base
  include TheRole::Api::Role

  scope :get_role, lambda { where.not(name: ["admin", "super_admin"]) }
end
