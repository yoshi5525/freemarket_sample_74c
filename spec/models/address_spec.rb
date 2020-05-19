require 'rails_helper'
describe Address do
  describe '#create_address' do
    it "first_name、family_name、first_name_kana、family_name_kana、post_code、prefecture、city、addressが存在すれば登録できること" do
      address = build(:address)
      expect(address).to be_valid
    end


    it "first_nameがない場合は登録できないこと" do
      address = build(:address, first_name: nil)
      address.valid?
      expect(address.errors[:first_name]).to include("を入力してください")
    end

    it "first_nameが全角のみの場合は登録できること" do
      address = build(:address, first_name: "太郎")
      address.valid?
      expect(address).to be_valid
    end

    it "first_nameに半角が含まれている場合は登録できないこと" do
      address = build(:address, first_name: "ﾀ郎")
      address.valid?
      expect(address.errors[:first_name]).to include("は不正な値です")
    end


    it "family_nameがない場合は登録できないこと" do
      address = build(:address, family_name: nil)
      address.valid?
      expect(address.errors[:family_name]).to include("を入力してください")
    end

    it "family_nameが全角のみの場合は登録できること" do
      address = build(:address, family_name: "山田")
      address.valid?
      expect(address).to be_valid
    end

    it "family_nameに半角が含まれている場合は登録できないこと" do
      address = build(:address, family_name: "山ﾀﾞ")
      address.valid?
      expect(address.errors[:family_name]).to include("は不正な値です")
    end


    it "first_name_kanaがない場合は登録できないこと" do
      address = build(:address, first_name_kana: nil)
      address.valid?
      expect(address.errors[:first_name_kana]).to include("を入力してください")
    end

    it "first_name_kanaが全角カタカナのみの場合は登録できること" do
      address = build(:address, first_name_kana: "タロウ")
      address.valid?
      expect(address).to be_valid
    end

    it "first_name_kanaにカタカナ以外が含まれている場合は登録できないこと" do
      address = build(:address, first_name_kana: "たロウ")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("は不正な値です")
    end

    it "first_name_kanaに半角が含まれている場合は登録できないこと" do
      address = build(:address, first_name_kana: "ﾀロウ")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("は不正な値です")
    end


    it "family_name_kanaがない場合は登録できないこと" do
      address = build(:address, family_name_kana: nil)
      address.valid?
      expect(address.errors[:family_name_kana]).to include("を入力してください")
    end

    it "family_name_kanaが全角カタカナのみの場合は登録できること" do
      address = build(:address, family_name_kana: "ヤマダ")
      address.valid?
      expect(address).to be_valid
    end

    it "family_name_kanaにカタカナ以外が含まれている場合は登録できないこと" do
      address = build(:address, family_name_kana: "やマダ")
      address.valid?
      expect(address.errors[:family_name_kana]).to include("は不正な値です")
    end

    it "family_name_kanaに半角が含まれている場合は登録できないこと" do
      address = build(:address, family_name_kana: "ﾔマダ")
      address.valid?
      expect(address.errors[:family_name_kana]).to include("は不正な値です")
    end

    it "post_codeがない場合は登録できないこと" do
      address = build(:address, post_code: nil)
      address.valid?
      expect(address.errors[:post_code]).to include("を入力してください")
    end

    it "post_codeが〇〇〇-〇〇〇〇場合は登録できること" do
      address = build(:address, post_code: "000-0000")
      address.valid?
      expect(address).to be_valid
    end

    it "post_codeが〇〇〇-〇〇〇〇でない場合は登録できないこと" do
      address = build(:address, post_code: "0000-000")
      address.valid?
      expect(address.errors[:post_code]).to include("は不正な値です")
    end

    it "post_codeが数字でない場合は登録できないこと" do
      address = build(:address, post_code: "aaa-aaaa")
      address.valid?
      expect(address.errors[:post_code]).to include("は不正な値です")
    end

    it "tel_numberがなくても登録できること" do
      address = build(:address, tel_number: "")
      address.valid?
      expect(address).to be_valid
    end

    it "重複したtel_numberが存在する場合登録できないこと" do
      user = create(:user)
      address = create(:address, user_id: user.id)
      address = build(:address)
      address.valid?
      expect(address.errors[:tel_number]).to include("はすでに存在します")
    end

    it "tel_numberが10けたの場合は登録できること" do
      address = build(:address, tel_number: "1234567890")
      address.valid?
      expect(address).to be_valid
    end

    it "tel_numberが9けた未満の場合は登録できないこと" do
      address = build(:address, tel_number: "123456789")
      address.valid?
      expect(address.errors[:tel_number]).to include("は不正な値です")
    end

    it "tel_numberが11けたの場合は登録できること" do
      address = build(:address, tel_number: "12345678901")
      address.valid?
      expect(address).to be_valid
    end

    it "tel_numberが12けた以上の場合は登録できないこと" do
      address = build(:address, tel_number: "123456789012")
      address.valid?
      expect(address.errors[:tel_number]).to include("は不正な値です")
    end


    it "apartmentがなくても登録できること" do
      address = build(:address, apartment: "")
      address.valid?
      expect(address).to be_valid
    end


    it "prefectureが選択されている場合登録できること" do
      address = build(:address, prefecture: "1")
      address.valid?
      expect(address).to be_valid
    end

    it "prefectureが選択されていない場合登録できないこと" do
      address = build(:address, prefecture: nil)
      address.valid?
      expect(address.errors[:prefecture]).to include("を選択してください")
    end

  end
end