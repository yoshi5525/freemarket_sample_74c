FactoryBot.define do

  factory :address do

    first_name            {"太郎"}
    family_name           {"山田"}
    first_name_kana       {"タロウ"}
    family_name_kana      {"ヤマダ"}
    post_code             {"123-4567"}
    prefecture            {"2"}
    city                  {"ど田舎市"}
    address               {"田んぼ"}
    apartment             {"西の稲"}
    tel_number            {"1234567890"}

  end
end