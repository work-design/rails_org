class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile
  has_one_attached :resume

  enum birthday_type: {
    gregorian: '1',
    lunar: '2'
  }
  enum gender: {
    male: '1',
    female: '2'
  }

  def age
    return 0 unless self.birthday
    r_hash = TimeHelper.exact_distance_time(self.birthday, Date.today)
    r_hash[:year]
  end

end
