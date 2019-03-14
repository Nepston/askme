class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :value
      t.timestamps
    end

    add_reference :tags, :questions, foreign_key: true
  end
end
