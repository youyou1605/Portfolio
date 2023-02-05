Rails.application.routes.draw do
  devise_for :admin,skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}
  devise_for :customer,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  root "homes#top"		
  get "/home/about" => "homes#about", as: "about"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
