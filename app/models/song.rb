class Song < ActiveRecord::Base
  validates :title, presence: true
  validate :released_and_released_year
  validate :future_release_year
  validate :first_release

  def released_and_released_year
    if self.released == true && self.release_year.nil?
      errors.add(:release_year, "Cannot receive release year if song was not released")
    end
  end

  def future_release_year
    if self.release_year != nil
      errors.add(:release_year, "cannot be in the future") unless self.release_year <= Time.now.year
    end
  end

  def first_release
    other_songs = Song.select do |song|
      song.title == self.title && song.release_year == self.release_year
    end
    
    errors.add(:release_year, "cannot release song more than once a year") if other_songs.length > 0
  end

end
