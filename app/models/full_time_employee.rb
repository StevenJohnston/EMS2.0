class FullTimeEmployee < ActiveRecord::Base
  belongs_to :employee, :dependent => :destroy

  validates :dateOfHire, presence: true
  validates :salary, presence: true
end
