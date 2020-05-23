require 'rails_helper'

RSpec.describe Card, type: :model do
  describe '#create' do

      it "登録完了" do
        card = build(:card)
        expect(card).to be_valid
      end

      it "user_idが空のとき登録できない" do
        card = build(:card, user_id: "")
        card.valid?
        expect(card.errors[:user_id]).to include("を入力してください")
      end

      it "customer_idが空のとき登録できない" do
        card = build(:card, customer_id: "")
        card.valid?
        expect(card.errors[:customer_id]).to include("を入力してください")
      end

      it "card_idが空のとき登録できない" do
        card = Card.new(card_id: nil)
        card.valid?
        expect(card.errors[:card_id]).to include("を入力してください")
      end
  end
end