$:.unshift File.expand_path("./../lib", __FILE__)
require './lib/schedules/schedule'

namespace :db do
  desc "migrate your database"
  task :migrate do
    require 'bundler'
    Bundler.require
    require './config/environment'
    ActiveRecord::Migrator.migrate('db/migrate')

    Schedule.create({ mday: 1, mday_max: 8, wday: 3, description: "Haircut appointment", img_name: "haircut.jpg" })
    Schedule.create({ mday: 15, description: "Breakfast Meeting", img_name: "breakfast.jpg" })
  end
end
