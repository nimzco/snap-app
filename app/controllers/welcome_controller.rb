class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user!,  only: :index#, only: :wrong_domain
  def index
  	render :layout => 'public'
  end 

  def wrong_domain
  	render :layout => 'public'
  end
end