class Theme < ActiveRecord::Base
    has_many :legos

    validates :name, presence: true
end