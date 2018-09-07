class Song < ActiveRecord::Base

    validates :title, {
        presence: true,
        length: {minimum: 1}
        #must be unique in artist.songs for current year
    }
    validates :released, {
        inclusion: {in: [true, false]}
    }
    validate :release_year, {
        presence: true,
        numericality: {
            less_than_or_equal_to: Date.today.year
        }
    }, unless: :is_released?
    validates :artist_name, {
        presence: true
    }
  
    def is_released?
        self.released
    end

end
