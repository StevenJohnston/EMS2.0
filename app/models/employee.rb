class Employee < ActiveRecord::Base
  belongs_to :company
  validates :firstName, presence:true

  validates :sin, presence:true
  validates :sin,format:{ with: /\A(\d{3}-\d{3}-\d{3})|(\d{9})\Z/i , message: "Sin format \#\#\#-\#\#\#-\#\#\#"}

  validates :dateOfBirth, presence:true
  validates :company_id, presence:true
end
