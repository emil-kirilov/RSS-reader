Rails.application.routes.draw do
	resources :feeds
	resources :posts
	get '/reader' => 'posts#ordered_index'
end
