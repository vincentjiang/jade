class PagesController < ApplicationController
	skip_before_filter :authorize, only: [:index, :about]

  def index
  end

  def about
  end
end
