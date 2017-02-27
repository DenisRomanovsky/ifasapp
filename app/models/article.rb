class Article < ActiveRecord::Base
  belongs_to :mechanism_category

  validates_presence_of :mechanism_category_id, :article_text
end
