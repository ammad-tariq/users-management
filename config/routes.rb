Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home'
  post 'pages/import_file'
end
