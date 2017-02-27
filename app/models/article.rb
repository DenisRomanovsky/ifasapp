class Article < ActiveRecord::Base
  belongs_to :mechanism_category

  validates_presence_of :category_id, :article_text
end
