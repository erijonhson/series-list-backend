
Rails.application.routes.draw do

  namespace :api, defaults: { format: :json }, path: '/api' do
    namespace :v1, path: '/v1' do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :series, only: [:index, :show, :create, :update, :destroy]
    end

    # for to create new api version
    # namespace :v1, path: '/v1' do
    #   resources :whatever, only: [:show, :create, :update, :destroy]
    # end
  end

end
