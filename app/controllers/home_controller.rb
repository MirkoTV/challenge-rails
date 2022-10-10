
class HomeController < ApplicationController
  def index
    @counter = ViewCount.increment('/')
  end
end
