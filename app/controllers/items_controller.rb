class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])  # ①インスタンス変数にセット
    @item.update(item_params)   # ②updateメソッドの実行
    if @item.update(item_params)
      redirect_to @item
    else
      render :show
    end
  end



  def destroy
  end

  def show
  end

  def confirm
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :condition, :area_id, :size, :price, :preparation_day, :postage, images_attributes: [:image])
  end
end
