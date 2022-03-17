class Customers::ItemsController < ApplicationController
    
    before_action :move_to_signed_in, except: [:index]
    def index
         @items = Item.all.page(params[:page]).per(10)
        #   if @item.is_active == true 
        #   販売中
        #   else 
        #   販売停止中
        #   end 
        #  redirect_to request.referer
    end
        
    def show
        @item = Item.find(params[:id])
        @cart_item = CartItem.new
    end
        
        def search
            @items = Item.search(params[:keyword]).page(params[:page]).per(10)
            @keyword = params[:keyword]
            render "index"
        end
        
        private
        
        def move_to_signed_in
            unless customer_signed_in?
            #サインインしていないユーザーはログインページが表示される
            redirect_to  new_customer_session_path
            end
        end

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :is_active, :genre_id)
  end
end
