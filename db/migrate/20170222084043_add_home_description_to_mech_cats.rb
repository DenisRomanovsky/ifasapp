class AddHomeDescriptionToMechCats < ActiveRecord::Migration
  def change
    add_column :mechanism_categories , :home_description, :text
  end
end
