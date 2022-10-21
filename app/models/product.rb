class Product < ApplicationRecord
    validates :product_code, uniqueness: true, presence: true
end