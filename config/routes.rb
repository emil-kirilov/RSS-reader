Rails.application.routes.draw do
	resources :feeds
	resources :posts, only: %i(index ordered_index destroy)
	get '/reader' => 'posts#ordered_index'
end
