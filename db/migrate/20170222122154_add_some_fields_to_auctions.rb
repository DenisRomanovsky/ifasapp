class AddSomeFieldsToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions , :delivery_included, :boolean
    add_column :auctions , :cash_payed, :boolean
    add_column :auctions , :with_tax, :boolean
  end
end
