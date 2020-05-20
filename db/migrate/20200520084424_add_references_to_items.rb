class AddReferencesToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :seller, type: :integer, null: false, foreign_key: true
  end
end