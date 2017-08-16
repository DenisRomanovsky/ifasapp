# frozen_string_literal: true

ActiveAdmin.register Feedback do
  permit_params :feedback_text, :user_id
end
