class Lego < ActiveRecord::Base
    belongs_to :user
    belongs_to :theme

    validates :name, presence: true
    validates :theme_id, presence: true
    validates :num_of_pieces, numericality: { only_integer: true }

end