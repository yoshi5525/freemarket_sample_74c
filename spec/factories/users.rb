FactoryBot.define do

  factory :user do
    nickname              {"よくいるやつ"}
    email                 {"kkk@gmail.com"}
    password              {"00000poo"}
    password_confirmation {"00000poo"}
    first_name            {"太郎"}
    family_name           {"山田"}
    first_name_kana       {"タロウ"}
    family_name_kana      {"ヤマダ"}
    birth_year            {"1980"}
    birth_month           {"1"}
    birth_day             {"1"}
  end

end