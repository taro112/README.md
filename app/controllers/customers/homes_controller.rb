class Customers::HomesController < ApplicationController
    
    def top
        @items = Item.limit(4).order('id DESC')
    end
end
