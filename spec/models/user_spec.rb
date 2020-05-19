require 'rails_helper'
describe User do
  describe '#create' do
    it "nickname、email、passwordとpassword_confirmation、first_name、family_name、first_name_kana、family_name_kana、birth_year、birth_month、birth_dayが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end


    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end


    it "emailがない場合は登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "重複したemailが存在する場合登録できないこと" do
      user = create(:user)
      user = build(:user)
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end


    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "passwordが7文字以上の場合は登録できること" do
      user = build(:user, password: "poppo00", password_confirmation: "poppo00")
      user.valid?
      expect(user).to be_valid
    end

    it "passwordが6文字以下の場合は登録できないこと" do
      user = build(:user, password: "poppo0")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "passwordに英字が1文字以上含まれている場合は登録できること" do
      user = build(:user, password: "p000000", password_confirmation: "p000000")
      user.valid?
      expect(user).to be_valid
    end

    it "passwordに英字が含まれていない場合は登録できないこと" do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      user.valid?
      expect(user.errors[:password]).to include("は英字と数字を最低1つ入力してください")
    end

    it "passwordに数字が1文字以上含まれている場合は登録できること" do
      user = build(:user, password: "poppop0", password_confirmation: "poppop0")
      user.valid?
      expect(user).to be_valid
    end

    it "passwordに数字が含まれていない場合は登録できないこと" do
      user = build(:user, password: "poppopo", password_confirmation: "poppopo")
      user.valid?
      expect(user.errors[:password]).to include("は英字と数字を最低1つ入力してください")
    end

    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end


    it "first_nameがない場合は登録できないこと" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    it "first_nameが全角のみの場合は登録できること" do
      user = build(:user, first_name: "太郎")
      user.valid?
      expect(user).to be_valid
    end

    it "first_nameに半角が含まれている場合は登録できないこと" do
      user = build(:user, first_name: "ﾀ郎")
      user.valid?
      expect(user.errors[:first_name]).to include("は不正な値です")
    end


    it "family_nameがない場合は登録できないこと" do
      user = build(:user, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end

    it "family_nameが全角のみの場合は登録できること" do
      user = build(:user, family_name: "山田")
      user.valid?
      expect(user).to be_valid
    end

    it "family_nameに半角が含まれている場合は登録できないこと" do
      user = build(:user, family_name: "山ﾀﾞ")
      user.valid?
      expect(user.errors[:family_name]).to include("は不正な値です")
    end


    it "first_name_kanaがない場合は登録できないこと" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end

    it "first_name_kanaが全角カタカナのみの場合は登録できること" do
      user = build(:user, first_name_kana: "タロウ")
      user.valid?
      expect(user).to be_valid
    end

    it "first_name_kanaにカタカナ以外が含まれている場合は登録できないこと" do
      user = build(:user, first_name_kana: "たロウ")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は不正な値です")
    end

    it "first_name_kanaに半角が含まれている場合は登録できないこと" do
      user = build(:user, first_name_kana: "ﾀロウ")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は不正な値です")
    end


    it "family_name_kanaがない場合は登録できないこと" do
      user = build(:user, family_name_kana: nil)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("を入力してください")
    end

    it "family_name_kanaが全角カタカナのみの場合は登録できること" do
      user = build(:user, family_name_kana: "ヤマダ")
      user.valid?
      expect(user).to be_valid
    end

    it "family_name_kanaにカタカナ以外が含まれている場合は登録できないこと" do
      user = build(:user, family_name_kana: "やマダ")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は不正な値です")
    end

    it "family_name_kanaに半角が含まれている場合は登録できないこと" do
      user = build(:user, family_name_kana: "ﾔマダ")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は不正な値です")
    end


    it "birth_yearが選択されている場合は登録できること" do
      user = build(:user, birth_year: "2020")
      user.valid?
      expect(user).to be_valid
    end

    it "birth_yearが--の場合は登録できないこと" do
      user = build(:user, birth_year: "--")
      user.valid?
      expect(user.errors[:birth_year]).to include("を選択してください")
    end


    it "birth_monthが選択されている場合は登録できること" do
      user = build(:user, birth_month: "1")
      user.valid?
      expect(user).to be_valid
    end

    it "birth_monthが--の場合は登録できないこと" do
      user = build(:user, birth_month: "--")
      user.valid?
      expect(user.errors[:birth_month]).to include("を選択してください")
    end


    it "birth_dayが選択されている場合は登録できること" do
      user = build(:user, birth_day: "1")
      user.valid?
      expect(user).to be_valid
    end

    it "birth_dayが--の場合は登録できないこと" do
      user = build(:user, birth_day: "--")
      user.valid?
      expect(user.errors[:birth_day]).to include("を選択してください")
    end
  end
end