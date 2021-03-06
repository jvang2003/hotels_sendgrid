class Availability < ActiveModel::Validator
  def validate(record)
    rooms = Room.where("rooms.id NOT IN (SELECT reservations.room_id from reservations WHERE NOT( reservations.check_out <= ? OR reservations.check_in >= ?) )",record.check_in,record.check_out)
    room = rooms.find { |room| room.id == record.room_id }
    if room.nil?
      record.errors.clear
      record.errors.add :base, 'The date you requested is taken, You can either check for other dates or check for other rooms maybe available. We Apologize for the inconvinience.'
      false
    end
  end
end