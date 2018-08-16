class Song < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :released, inclusion: { in: [true, false] }
  validates :release_year, presence: true, if: :is_it_released, numericality: { less_than_or_equal_to: DateTime.now.year }
  validates :artist_name, presence: true
  validates :genre, presence: true

  def is_it_released
    released == true
  end
end
