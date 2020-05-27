class ItemsController < ApplicationController
  before_action :set_item, only:[:edit, :update, :destroy, :show, :confirm, :pay]
  before_action :move_to_index, except:[:index, :show, :confirm]
  before_action :move_to_session, only:[:confirm]
  before_action :sold_check, only:[:confirm]

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
      @item.images.new
      render :new
    end
  end

  def edit
    if @item.seller_id != current_user.id
      redirect_to root_path, alert: "不正なアクセスです。"
    end

    grandchild_category = @item.category
    child_category = grandchild_category.parent

    @category_parent_array = Category.where(ancestry: nil)
    @category_children_array = Category.where(ancestry: child_category.ancestry)
    @category_grandchildren_array = Category.where(ancestry: grandchild_category.ancestry)
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      grandchild_category = @item.category
      child_category = grandchild_category.parent

      @category_parent_array = Category.where(ancestry: nil)
      @category_children_array = Category.where(ancestry: child_category.ancestry)
      @category_grandchildren_array = Category.where(ancestry: grandchild_category.ancestry)
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
    if current_user.id == @item.seller_id
      redirect_to root_path
    end
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    if Card.where(user_id: current_user.id).blank?
      flash[:alert] = "クレジットカードを登録してください"
      redirect_to new_card_path
    else
      set_address
      card = Card.where(user_id: current_user.id).first
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
  end

  def pay
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    Payjp::Charge.create(
      amount: @item.price,
      customer: card.customer_id,
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

  def set_address
    @address = Address.find_by(user_id: current_user.id)
    @area = Area.find(@address.prefecture)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def move_to_session
    unless user_signed_in?
      redirect_to new_user_session_path
      flash[:alert] = "ログインしてください"
    end
  end

  def sold_check
    if @item.buyer_id != nil
      redirect_to root_path
    end
  end
end

