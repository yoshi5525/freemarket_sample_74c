class ItemsController < ApplicationController
  before_action :set_item, only:[:edit, :update, :destroy, :show]
  before_action :move_to_index, except:[:index, :show]

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
    if @item.seller_id != current_user.id
      redirect_to root_path, alert: "不正なアクセスです。"
    end
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

  def set_parents
    @parents  = Category.where(ancestry: nil)
  end

  def set_children
    @children = Category.where(ancestry: params[:parent_id])
  end

  def set_grandchildren
    @grandchildren = Category.where(ancestry: params[:ancestry])
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :condition, :area_id, :category_id, :size, :price, :preparation_day, :postage, :brand, images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end

