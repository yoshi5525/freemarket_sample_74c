class ItemsController < ApplicationController
  before_action :set_item, except:[:index, :new, :create, :confirm]

  def index
    @items = Item.order(created_at: :desc)
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
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit
    end
  end



  def destroy
    @item.destroy
    redirect_to root_path
  end

  def show
  end

  def confirm
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :condition, :area_id, :size, :price, :preparation_day, :postage, images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end

