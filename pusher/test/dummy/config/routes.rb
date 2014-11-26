Rails.application.routes.draw do

  mount Pusher::Engine => "/pusher"
end
