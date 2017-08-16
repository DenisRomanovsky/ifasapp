# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id                    :integer          not null, primary key
#  mechanism_category_id :integer
#  article_text          :text
#  created_at            :datetime
#  updated_at            :datetime
#

class Article < ActiveRecord::Base
  belongs_to :mechanism_category

  validates_presence_of :mechanism_category_id, :article_text
end
