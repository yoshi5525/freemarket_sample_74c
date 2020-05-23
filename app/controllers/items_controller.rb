class ItemsController < ApplicationController

  before_action :set_item, only:[:edit, :update, :destroy, :show, :confirm, :pay]
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
    @user = current_user
    card = Card.where(user_id: current_user.id).first
    @address = Address.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = customer.cards.retrieve(card.card_id)
    @card_brand = @default_card_information.brand
    case @card_brand
    when "Visa"
      @card_image = "/visa.svg"
    when "JCB"
      @card_image = "/jcb.svg"
    when "MasterCard"
      @card_image = "/master-card.svg"
    when "American Express"
      @card_image = "/american_express.svg"
    when "Diners Club"
      @card_image = "/dinersclub.svg"
    when "Discover"
      @card_image = "/discover.svg"
    end
  end

  def pay
    @card = Card.where(user_id: current_user.id).first
    Payjp::Charge.create(
      amount: @item.price,
      customer: @card.customer_id,
      currency: 'jpy'
    )
    @item.update(buyer_id: current_user.id)
    redirect_to root_path
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

