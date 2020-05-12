class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string       :name,            null: false
      t.text         :introduction,    null: false
      # t.references   :category,        null: false, foreign_key: true
      # t.references   :brand,                        foreign_key: true
      t.string       :condition,       null: false
      t.string       :area,            null: false
      t.string       :size
      t.integer      :price,           null: false
      t.integer      :preparation_day, null: false
      t.integer      :postage,         null: false
      # t.references   :seller,          null: false, foreign_key: true
      # t.references   :buyer,                        foreign_key: true
      t.timestamps
    end
  end
end
