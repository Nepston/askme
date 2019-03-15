class CreateHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags do |t|
      t.text :value

      t.timestamps
    end
    add_index :hashtags, :value, unique: true
  end
end
