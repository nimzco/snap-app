class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # if uncomment line below, application does not start !!! Strange...
  # set_current_tenant_by_subdomain(:account, :subdomain)

  before_filter :authenticate_user! #:check_subdomain, :set_mailer_host
  before_filter :configure_permitted_parameters, if: :devise_controller?

  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat([:firstname])
  end


  private

  def current_account
    @current_account ||= Account.find_by(subdomain: request.subdomain)
  end
  helper_method :current_account

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def after_invite_path_for(resource)
    users_path
  end

  #def check_subdomain
  #  account = Account.find_by(subdomain: request.subdomain)
  #  if account
  #    set_current_tenant_by_subdomain(:account, :subdomain)
  #  else
  #    redirect_to "http://www.rubyonrails.org"
  #  end
  #end  

end
