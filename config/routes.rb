Rails.application.routes.draw do
  #ユーザ用
  devise_for :users,  skip: [:passwords],  controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  
  #管理者用
  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: "public/homes#top"
  get "/about" => "public/homes#about"
  
  scope module: :public do
    resources :articles
    resources :users
  end
  
  
end

