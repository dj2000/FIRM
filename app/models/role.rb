class Role < ActiveRecord::Base
  include TheRole::Api::Role

  def self.get_role
    Role.where.not(name: ["admin", "super_admin"]).pluck(:title, :id)
  end
end
