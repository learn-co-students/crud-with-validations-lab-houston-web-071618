class Song < ActiveRecord::Base

    validates :title, {
        presence: true,
        length: {minimum: 1},
        uniqueness: {scope: [:release_year, :artist_name]}
    }
    validates :released, {
        inclusion: {in: [true, false]}
    }
    validates :release_year, {
        presence: true,
        numericality: {
            less_than_or_equal_to: Date.today.year
        }, 
        if: :released?
    } 
        
    validates :artist_name, {
        presence: true
    }
  
    def released?
        self.released
    end


end
