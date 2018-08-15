# class Song < ActiveRecord::Base
#   validates :title, presence: true
#   validates :title, uniqueness: { scope: [:release_year, :artist_name] }
#   validates :released, inclusion: { in: %w(true false) }
#   validate :check_year_released
#   validates :genre, presence: true
#   validates :artist_name, presence: true
# 
#   def check_year_released
#     self.released && self.release_year >= Time.current.year
#   end
# end

class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: {
    scope: [:release_year, :artist_name],
    message: "cannot be repeated by the same artist in the same year"
  }
  validates :released, inclusion: { in: [true, false] }
  validates :artist_name, presence: true

  with_options if: :released? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: {
      less_than_or_equal_to: Date.today.year
    }
  end

  def released?
    released
  end
end
