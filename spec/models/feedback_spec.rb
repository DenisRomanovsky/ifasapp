# frozen_string_literal: true

# == Schema Information
#
# Table name: feedbacks
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  feedback_text :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  email         :string
#

require 'rails_helper'

RSpec.describe Feedback, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
