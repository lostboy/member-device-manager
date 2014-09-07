class Membership::Level < ActiveRecord::Base
  has_many :members

  def to_s
    self.name
  end
end
