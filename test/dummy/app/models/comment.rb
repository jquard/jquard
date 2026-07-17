class Comment < ApplicationRecord
  validates :author_name, presence: true
end
