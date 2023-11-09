class Current < ApplicationRecord
  cattr_accessor :user

  def self.set(user)
    self.user = user
  end

  def self.get
    self.user
  end
end