require 'rails_helper'
describe Item, type: :model do
  let(:category) { create(:category)}

  describe '#create' do
    context 'itemを保存できる場合' do
      it "全ての項目が入力されていれば保存できること" do
        expect(build(:item, category_id: category[:id])).to be_valid
      end

      it "brandがない場合でも保存できること" do
        expect(build(:item, category_id: category[:id], brand: nil)).to be_valid
      end

      it "sizeがない場合でも保存できること" do
        expect(build(:item, category_id: category[:id], size: nil)).to be_valid
      end

      it "buyer_idがない場合でも保存できること" do
        expect(build(:item, category_id: category[:id], buyer_id: nil)).to be_valid
      end
    end

    context 'itemを投稿できない場合' do
      it "nameがない場合は投稿できないこと" do
        item = build(:item, category_id: category[:id], name: nil)
        item.valid?
        expect(item.errors[:name]).to include("は1文字以上で入力してください", "を入力してください")
      end

      it "introductionがない場合は投稿できないこと" do
        item = build(:item, category_id: category[:id], introduction: nil)
        item.valid?
        expect(item.errors[:introduction]).to include("は1文字以上で入力してください", "を入力してください")
      end

      it "category_idがない場合は投稿できないこと" do
        item = build(:item, category_id: category[:id], category_id: nil)
        item.valid?
        expect(item.errors[:category]).to include("を入力してください")
      end
      
      it "conditionがない場合は投稿できないこと" do
        item = build(:item, category_id: category[:id], condition: nil)
        item.valid?
        expect(item.errors[:condition]).to include("を入力してください")
      end
      
      it "area_idがない場合は投稿できないこと" do
        item = build(:item, category_id: category[:id], area_id: nil)
        item.valid?
        expect(item.errors[:area]).to include("を入力してください")
      end
      
      it "priceがない場合は投稿できないこと" do
        item = build(:item, category_id: category[:id], price: nil)
        item.valid?
        expect(item.errors[:price]).to include("は数値で入力してください", "を入力してください")
      end
      
      it "preparation_dayがない場合は投稿できないこと" do
        item = build(:item, category_id: category[:id], preparation_day: nil)
        item.valid?
        expect(item.errors[:preparation_day]).to include("を入力してください")
      end
      
      it "postageがない場合は投稿できないこと" do
        item = build(:item, category_id: category[:id], postage: nil)
        item.valid?
        expect(item.errors[:postage]).to include("を入力してください")
      end
      
      it "seller_idがない場合は投稿できないこと" do
        item = build(:item, category_id: category[:id], seller_id: nil)
        item.valid?
        expect(item.errors[:seller_id]).to include("を入力してください")
      end
      
      it "statusがない場合は投稿できないこと" do
        item = build(:item, category_id: category[:id], status: nil)
        item.valid?
        expect(item.errors[:status]).to include("を入力してください")
      end
    end

    context 'item投稿時の境界値テスト' do
      it "nameが40文字以下であれば保存できること" do
        expect(build(:item, category_id: category[:id], name: "a" * 40)).to be_valid
      end

      it "nameが41文字以上では投稿できないこと" do
        item = build(:item, category_id: category[:id], name: "a" * 41)
        item.valid?
        expect(item.errors[:name]).to include("は40文字以内で入力してください")
      end

      it "introductionが1000文字以下であれば保存できること" do
        expect(build(:item, category_id: category[:id], introduction: "a" * 1000)).to be_valid
      end

      it "introductionが1001文字以上では投稿できないこと" do
        item = build(:item, category_id: category[:id], introduction: "a" * 1001)
        item.valid?
        expect(item.errors[:introduction]).to include("は1000文字以内で入力してください")
      end

      it "priceが300円以上であれば保存できること" do
        expect(build(:item, category_id: category[:id], price: "300")).to be_valid
      end

      it "priceが299円以下では投稿できないこと" do
        item = build(:item, category_id: category[:id], price: "299")
        item.valid?
        expect(item.errors[:price]).to include("は299より大きい値にしてください")
      end

      it "priceが9999999円以下であれば保存できること" do
        expect(build(:item, category_id: category[:id], price: "9999999")).to be_valid
      end

      it "priceが10000000円以上では投稿できないこと" do
        item = build(:item, category_id: category[:id], price: "10000000")
        item.valid?
        expect(item.errors[:price]).to include("は10000000より小さい値にしてください")
      end
    end
  end
end