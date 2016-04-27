require 'sinatra'

class YieldService < Sinatra::Base
  get '/' do
    "Hello, world!"
  end

  get '/:name' do
    "Hello, #{params[:name]}!"
  end
end
