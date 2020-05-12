class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item
    else
      render :new
    end
  end

  def show
  end

  def confirm
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :condition, :area_id, :size, :price, :preparation_day, :postage)
    # params.requier(:item).permit(:name, :introduction, :condition, :area_id, :size, :price, :preparation_day, :postage, :category_id, :brand_id).merge(seller_id: current_user.id)
  end
end
