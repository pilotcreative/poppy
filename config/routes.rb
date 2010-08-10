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
      put :add
      get :ping
      get :library
    end
  end
  resource :playlist, :only =>[:move_song, :clear, :delete_song, :show] do
    post :move_song
    delete :clear
    delete :delete_song
  end
  resource :song_search, :only => [:new, :create]
  root :to => "players#index"
end
