require 'sinatra'
require 'time'
require './src/cron'
require './lib/schedules'
require 'yaml'

db_options = YAML.load(File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection(db_options)

class YieldService < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/events' do
    cron = Cron.new
    schedules = Schedule.all.to_a
    n, event = cron.next_event(Date.parse(params[:my_date]), schedules)
    @next_event = n.strftime('%d %B %Y')
    @event = event
    erb :index
  end
end
