class Product < ActiveRecord::Base
  before_save { self.name = name.downcase }
  validates :name,  presence: true, length: { maximum: 100 },
                    uniqueness: { case_sensitive: false }
  validates :price, presence: true
end
