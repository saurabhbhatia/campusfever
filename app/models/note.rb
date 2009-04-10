class Note < ActiveRecord::Base
	belongs_to :sender, :class_name => 'Faculty', :foreign_key => 'sender_id'
	has_many :note_recipients
	has_many :recipients, :through => :note_recipients, :source => :faculty
	
	has_many :replies, :class_name => "Note", :foreign_key => "reply_to"
	belongs_to :reply_to, :class_name  => "Note", :foreign_key => "reply_to"
	
	belongs_to :group # in the case note is sent to a group
	belongs_to :private_group # in the case note is sent to a group
	
	def self.find_by_filter (faculty, filter)
		case filter
		when 'all'
			self.all_by_faculty faculty
		when 'notes'
			self.all_notes_by_faculty faculty
		when 'replies'
			self.replies_by_faculty faculty #all replies from and to this user
		when 'private'
			self.private_by_faculty faculty
		when 'nonpublic'
			self.nonpublic_by_faculty faculty
		when 'sent'
			faculty.sent_notes
		when 'links'
			self.find_by_type faculty, :links
		when 'files'
			self.find_by_type faculty, :files
		when 'events'
			self.find_by_type faculty, :events
		else # should be group
			m = /([a-z]+)_?(\d*)/.match(filter)
			if m[1] == 'set' 
				group_id = m[2].to_i
				self.find_by_group group_id
			elsif m[1] == 'pgroup'
				private_group_id = m[2].to_i
				self.find_by_group private_group_id
			end
		end
	end
	
	def self.all_by_faculty(faculty)
		public_notes = Note.find :all, :conditions => ["is_public = ?", true]
		received_notes = faculty.received_notes
		sent_notes = faculty.sent_notes
		
		all = public_notes + received_notes + sent_notes
		if !(all.nil?)
			all.sort_by { |note| note.created_at }
			all#.uniq!.reverse!
		end
	end
	
	def self.all_notes_by_faculty(faculty)
		public_notes = Note.find :all, :conditions => "is_public = true and reply_to is null"
		received_notes = Note.find_by_sql(['SELECT notes.* FROM notes ' + 
		'INNER JOIN note_recipients ON notes.id = note_recipients.note_id ' + 
		'WHERE (note_recipients.faculty_id = ?) and notes.reply_to is null', faculty.id])
		sent_notes = Note.find_by_sql(['select * from notes where faculty_id = ? and reply_to is null', faculty.id])
		all = public_notes + received_notes + sent_notes
		if !(all.nil?)
			all.sort_by { |note| note.created_at }
			all#.uniq!.reverse!
		end
	end
	
	def self.find_by_group(group_id)
		self.find :all, :condition => ["group_id =?", group_id]
	end
	
	def self.find_by_private_group(private_group_id)
		self.find :all, :condition => ["private_group_id =?", private_group_id]
	end
	
	def self.replies_by_faculty(faculty) 
		public_notes = Note.find :all, :conditions => "is_public = true and reply_to is null"
		sent_replies = Note.find :all, :conditions => ["faculty_id = ? and reply_to is not null", faculty]
		received_replies = Note.find_by_sql(['SELECT notes.* FROM notes ' + 
		'INNER JOIN note_recipients ON notes.id = note_recipients.note_id ' + 
		'WHERE (note_recipients.faculty_id = ?) and notes.reply_to is not null', faculty.id])
		all = public_notes + received_replies + sent_replies
		if !(all.nil?)
			all.sort_by { |note| note.created_at }
			all#.uniq!.reverse!
		end
	end
	
	def self.private_by_faculty(faculty)
		Note.find :all, :conditions => ["faculty_id = ? and group_id is null", faculty]
	end
	
	def self.nonpublic_by_faculty(faculty)
		Note.find :all, :conditions => ["is_public != true"]
	end
	
	def self.find_by_type(faculty, note_type)
		h = Hash['links' => 'LinkNote', 'files' => 'FileNote']
		Note.find :all, :conditions => ["`type` = ? and faculty_id = ?", h[note_type], faculty.id]
	end
end
