class Question < ApplicationRecord
  belongs_to :subgenre, dependent: :destroy
end
