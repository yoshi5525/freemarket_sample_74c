class ItemsController < ApplicationController

  def index
    @items = Item.all.order(created_at: :desc)
    # @items = Item.includes(:image).order(created_at: :DESC)
    # @items = Item.all.order(created_at: :desc)
    # @images = Image.all
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
  end

  def update
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
