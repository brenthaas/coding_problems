class CreateMurderStats < ActiveRecord::Migration
  def change
    create_table :murder_stats do |t|
      t.belongs_to :country, index: true, foreign_key: true
      t.integer :year
      t.integer :count
      t.float :rate

      t.timestamps null: false
    end
  end
end
