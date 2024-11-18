class PagesController < ApplicationController
  before_action :set_profiles

  def links
  end

  def about
  end

  def howto
  end

  def developer
  end

  private

  def set_profiles
    @profiles = current_user.profiles.all if user_signed_in?
  end

end
