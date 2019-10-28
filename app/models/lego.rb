class Lego < ActiveRecord::Base
    belongs_to :user

    validates :name, presence: true
    validates :theme, presence: true
    validates :num_of_pieces, numericality: { only_integer: true }

end