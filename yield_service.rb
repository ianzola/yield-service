require 'sinatra'

class YieldService < Sinatra::Base
  get '/' do
    "Hello, world!"
    erb :index
  end

  get '/:name' do
    "Hello, #{params[:name]}!"
  end
end
