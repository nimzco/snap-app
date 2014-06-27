# if subdomain url is empty or is 'www'
class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank? || request.subdomain == 'www'
  end
end


# if url has a subdomain and it is not 'www'
class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != 'www'
  end
end


Rails.application.routes.draw do

 constraints(SubdomainBlank) do
    resources :accounts, only: [:new, :create]
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    root 'welcome#index'
  end

  constraints(SubdomainPresent) do
    root 'users#index', as: :subdomain_root
    devise_for :users
    resources :users, only: :index
  end

 
end




  # devise_for :users
  # resources :accounts

  # match '', :via => [:get], to: 'users#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

