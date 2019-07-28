Rails.application.routes.draw do
  resources :shops, only: [:index, :show, :new, :create] do
    resources :opening_slots, controller: 'shops/opening_slots', except: [:index, :show, :destroy]
  end

  root to: 'shops#index'
end
