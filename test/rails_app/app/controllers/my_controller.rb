class MyController < ApplicationController
  forces_redirect_to_host
  
  def index
    render :inline => 'hello, world'
  end
end
