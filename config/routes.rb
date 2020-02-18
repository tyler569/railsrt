Rails.application.routes.draw do
  get '/routes', to: 'routes#all'
  get '/route/all/:dest', to: 'routes#to_all', dest: /.*/
  get '/route/:dest', to: 'routes#to', dest: /.*/
  
  post '/routes', to: 'routes#post'
  # patch '/route/:dest', to: 'routes#patch'
  delete '/routes', to: 'routes#reset'
  delete '/route/:dest', to: 'routes#del', dest: /.*/

  get '/status', to: 'status#status'

  get '/neighbors', to: 'neighbors#neighbors'
end
