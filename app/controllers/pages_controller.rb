class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end

  def about
  end

  def faq
  end

  def help_center
  end

  def news
  end

  def black_list
  end
end
