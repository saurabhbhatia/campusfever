class NoteRecipient < ActiveRecord::Base
	#belongs_to :note
	#belongs_to :faculty
	has_and_belongs_to_many :faculties
end
