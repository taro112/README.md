class CartItem < ApplicationRecord
    
    belongs_to :item
    belongs_to :customer
    
    def subtotal()
        #binding.pry
        item.with_tax_price * amount
    end
end
