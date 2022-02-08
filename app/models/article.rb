class Article < ApplicationRecord
    has_rich_text :content
    belongs_to :user #campo adicional
    has_many :has_categories # Relacion mucho a mucho (* a *)
    has_many :categories, through: :has_categories
    attr_accessor :category_elements

    def save_category
        # category_elements 1,2,3
        # Convertir eso en un arreglo 1,2,3 => [1,2,3]
        # categories_array = category_elements.split(",")
        # Iterar ese arreglo
        return has_categories.destroy_all if category_elements.nil? || category_elements.empty?

        has_categories.where.not(category_id: category_elements).destroy_all

        category_elements.each do |category_id|
            # Crear HasCategory Hascategory<article_id: 1, category_id: 2>
            HasCategory.find_or_create_by(article: self, category_id: category_id)
            # unless HasCategory.where(article: self, category_id: category_id).any?
            #     HasCategory.create(article: self, category_id: category_id)
            # end
        end
    end
end
