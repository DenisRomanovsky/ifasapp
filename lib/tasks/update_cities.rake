# frozen_string_literal: true

require 'csv'
namespace :cities do
  desc 'Scans through cities.csv and updates db.'
  task update: :environment do
    file = File.join(Rails.root, 'db', 'files', 'cities.csv')
    csv_text = File.read(file)
    if csv_text.present?
      City.delete_all
      csv = CSV.parse(csv_text, headers: false)
      csv.each do |row|
        City.create do |c|
          c.name = row[0]
        end
      end
      puts 'Cities are updated.'
    end
  end
end
