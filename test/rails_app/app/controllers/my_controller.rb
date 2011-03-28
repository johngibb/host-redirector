class MyController < ApplicationController
  def index
    render :inline => 'hello, world'
  end
end
