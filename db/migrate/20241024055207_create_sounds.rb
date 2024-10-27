class CreateSounds < ActiveRecord::Migration[7.0]
  def change
    create_table :sounds do |t|
      t.string :text, null: false
      t.references :profile, null: false, foreign_key: true
      t.timestamps
    end
  end
end
