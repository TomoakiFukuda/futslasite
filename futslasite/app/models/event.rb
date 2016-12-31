class Event < ActiveRecord::Base

validates :user_id, presence: true
validates :name, presence: true
validates :place, presence: true, length: { maximum: 100 }
validates :content, presence: true, length: { maximum: 2000 }
validate :start_time
validate :end_time
validate :start_time_should_be_before_end_time

belongs_to :user

paginates_per 3

private

def start_time_should_be_before_end_time
 return unless start_time && end_time

 if start_time >= end_time
 	errors.add('開始時間は終了時間よりも前に設定してください')
 end
end

def set_eventimage(file)
    if !file.nil?
      file_name = file.original_filename
      File.open("public/event_images/#{file_name}", 'wb'){|f| f.write(file.read)}
      self.image = file_name
    end
end


end