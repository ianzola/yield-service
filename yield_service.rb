require 'sinatra'
require 'time'
require './src/cron'
require './lib/schedules'
require 'yaml'
require './config/environment'

#db_options = YAML.load(File.read('./config/database.yml'))
#ActiveRecord::Base.establish_connection(db_options)

class YieldService < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/events' do
    cron = Cron.new
    schedules = Schedule.all.to_a
    begin
      valid_date = Date.parse(params[:my_date])
      n, event = cron.next_event(valid_date, schedules)
      @next_event = n.strftime('%d %B %Y')
      @event = event
    rescue
      @error = "Please enter a valid date in the format: DD-MM-YYYY"
    end
    erb :index
  end
end
