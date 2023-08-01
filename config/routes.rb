Rails.application.routes.draw do
  #ユーザ用
  devise_for :users,  skip: [:passwords],  controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  
  #管理者用
  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: "public/homes#top"
  get "/about" => "public/homes#about"
  get "/admin" => "admin/homes#top"
  
  
  scope module: :public do
    get '/search', to: 'searches#search'
    resources :articles do
      resources :article_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :favorites, only: [:index]
    resources :users do
      member do
        get 'unsubscribe'
        patch 'withdrawal'
      end
      resource :relationships, only: [:create, :destroy]
      get '/followings' => 'relationships#followings', as: 'followings'
      get '/followers' => 'relationships#followers', as: 'followers'
      get '/timeline' => 'relationships#timeline'
    end
  end
  
   namespace :admin do
     get '/search', to: 'searches#search'
     resources :articles, only: [:index, :show, :edit, :update, :destroy ] do
       resources :article_comments, only: [:destroy]
     end
     resources :users do
      get '/followings' => 'relationships#followings', as: 'followings'
      get '/followers' => 'relationships#followers', as: 'followers'
    end
  end
end


