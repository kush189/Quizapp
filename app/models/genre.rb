class Genre < ApplicationRecord
	has_many :subgenres , dependent: :destroy
end
