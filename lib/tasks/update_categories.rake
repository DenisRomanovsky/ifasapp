require 'csv'
################################################
# This script updates or inserts new categories
# and subcats based on description.
################################################
namespace :categories do

  desc 'Scans through categories.csv and updates db.'
  task update: :environment do
    file = File.join(Rails.root, 'db', 'files', 'categories.csv')
    csv_text = File.read(file)
    if csv_text.present?
      csv = CSV.parse(csv_text, :headers => false)
      csv.each do |row|
        category = MechanismCategory.where(description: row[1]).first_or_initialize
        category.home_description = row[0]
        category.save!
        MechanismSubcategory.where(mechanism_category: category, description: row[2]).first_or_create
        if row[3].present?
          article = Article.where(mechanism_category_id: category.id).first_or_initialize
          article.article_text = row[3]
          article.save!
        end
      end
      puts 'Categories are updated.'
    end
  end

  desc 'Removes all categories.'
  task delete: :environment do
    MechanismSubcategory.delete_all
    MechanismCategory.delete_all
    Article.delete_all
    puts 'Done! The db is clean like a virgin. Enjoy it.'
  end
end
