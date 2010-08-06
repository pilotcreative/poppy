Poppy::Application.routes.draw do |map|
  resource :player do
    member do
      put :play
      put :pause
      put :stop
      put :next
      put :previous
      put :volume
      put :volume_down
      put :volume_up
      put :seek
      get :ping
      get :library
      get :playlist
      put :add
    end
  end
  root :to => "players#index"
end
