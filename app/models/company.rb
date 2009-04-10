class Company < ActiveRecord::Base
  has_many :exams, :dependent => :nullify
end
