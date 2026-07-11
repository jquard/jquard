class Post < ApplicationRecord
  enum :status, { draft: 0, reviewing: 1, published: 2 }, default: :draft

  validates :title, presence: true, length: { maximum: 255 }
end
