class RecentAddBusiness < ActiveRecord::Base
  attr_accessible :business_id, :company_name
  validates :company_name, :uniqueness => true, :presence => true
end
