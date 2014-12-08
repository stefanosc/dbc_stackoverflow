class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :questions, :title
    add_index :questions, :content
  end
end
