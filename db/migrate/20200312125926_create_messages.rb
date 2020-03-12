class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.string :content_answer
      t.string :photo_answer

      t.timestamps
    end
  end
end
