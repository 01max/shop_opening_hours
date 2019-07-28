class CreateOpeningSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :opening_slots do |t|
      t.references :shop

      t.text :days_of_week, default: [].to_yaml
      t.integer :opening_at
      t.integer :closing_at

      t.timestamps null: false
    end
  end
end
