class PrototypeTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :prototype
end
