Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post 'message', to: 'messages#create'
  post 'message/:message_id/like', to: 'messages#like'
  get  'top_messages/:period', to: 'messages#top_messages'
  get 'messages_feed/:page', to: 'messages#messages_feed'
end
