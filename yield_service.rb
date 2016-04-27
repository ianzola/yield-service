require 'sinatra'
require './src/cron'

class YieldService < Sinatra::Base
  get '/:date' do
    cron = Cron.new
    @next_event = cron.next_event(Date.parse(params[:date]))
    erb :index
  end
end
