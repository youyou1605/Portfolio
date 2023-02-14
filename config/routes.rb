Rails.application.routes.draw do
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  namespace :public do
    resources :customers,only: [:show, :index, :edit, :create, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :posts,only: [:show, :index, :edit, :create, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end
  devise_for :admin,skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}
  devise_for :customer,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  root "homes#top"
  get "/home/about" => "homes#about", as: "about"

  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
