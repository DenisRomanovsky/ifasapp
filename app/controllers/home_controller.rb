# frozen_string_literal: true

class HomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    @categories = MechanismCategory.order('id ASC').all
  end
end
