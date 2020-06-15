class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :schedule, null: false, foreign_key: true
      t.text :reply

      t.timestamps
    end
  end
end
