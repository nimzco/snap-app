class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  set_current_tenant_by_subdomain(:account, :subdomain)

  before_filter :authenticate_user! 
  # before_filter :redirect_on_non_existing_subdomain, :authenticate_user!  #, :set_mailer_host
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


 # def redirect_on_non_existing_subdomain
 #   account = Account.find_by(subdomain: request.subdomain)
 #   if account
 #     set_current_tenant_by_subdomain(:account, :subdomain)
 #   else
 #     redirect_to "http://www.rubyonrails.org"
 #   end
 # end  

# autre approche http://stackoverflow.com/questions/13744710/devise-subdomain-based-app-redirect-to-default-vhost-when-no-user-found-under-s
end
