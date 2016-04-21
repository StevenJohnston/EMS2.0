class PartTimeEmployee < ActiveRecord::Base
  belongs_to :employee, :dependent => :destroy
  has_one :full_time_employee
  validates :dateOfHire, presence: true
end
