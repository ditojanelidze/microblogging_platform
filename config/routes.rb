Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post 'message', to: 'messages#create'
  post 'message/:message_id/like', to: 'messages#like'
end
