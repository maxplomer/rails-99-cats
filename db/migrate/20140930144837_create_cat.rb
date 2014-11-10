class CreateCat < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.integer :birth_date, null: false
      t.string :color, null: false
      t.string :name, null: false
      t.string :sex, null: false
      t.text :description, null: false

      t.timestamps
    end

#would like to enforce on or before today at db level
# validates_date :date_of_birth, :on_or_before =>
  end
end
