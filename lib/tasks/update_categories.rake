#require 'task_helpers/notification_test_helper'
require 'csv'
namespace :categories do
  #include NotificationTestHelper

  desc 'Scans through categories.csv and updates db.'
  task update: :environment do
    file = File.join(Rails.root, 'db', 'files', 'categories.csv')
    csv_text = File.read(file)
    if csv_text.present?
      MechanismSubcategory.delete_all
      MechanismCategory.delete_all
      csv = CSV.parse(csv_text, :headers => false)
      csv.each do |row|
        category = MechanismCategory.where(description: row[0]).first_or_create
        MechanismSubcategory.create() do |sc|
          sc.mechanism_category = category
          sc.description = row[1]
        end
      end
      puts 'Categories are updated.'
    end
  end
end
