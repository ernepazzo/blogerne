class Category < ApplicationRecord
    has_many :has_categories # Relacion mucho a mucho (* a *)
    has_many :articles, through: :has_categories
end
