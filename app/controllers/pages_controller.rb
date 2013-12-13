class PagesController < ApplicationController
	skip_before_filter :authenticate, only: [:index, :about]

  def index
  end

  def about
  end
end
