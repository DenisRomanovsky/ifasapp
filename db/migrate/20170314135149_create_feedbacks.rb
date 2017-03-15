class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.text :feedback_text

      t.timestamps null: false
    end
  end
end
