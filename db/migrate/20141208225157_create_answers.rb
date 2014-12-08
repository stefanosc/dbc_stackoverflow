class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :answers, :title
    add_index :answers, :content
  end
end
