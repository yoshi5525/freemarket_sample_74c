FactoryBot.define do
  factory :item do
    name            {"寸胴鍋"}
    introduction    {"寸胴鍋使いやすい"}
    brand           {"ex"}
    condition       {"one"}
    area_id         {1}
    size            {"lxl"}
    price           {777}
    preparation_day {"middle"}
    postage         {"including"}
    seller_id       {1}
    buyer_id        {2}
    status          {"saling_item"}
  end
end