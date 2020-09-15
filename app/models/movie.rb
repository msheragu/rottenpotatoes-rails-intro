class Movie < ActiveRecord::Base
    def self.all_ratings
        uniq_ratings = []
        self.select(:rating).uniq.each {|x| uniq_ratings << (x.rating)}
        uniq_ratings
    end
end
