require 'yaml'

  environment = ENV.fetch('RACK_ENV') { 'development' }
  db_options = YAML.load(File.read('./config/database.yml'))[environment]
  puts db_options
  ActiveRecord::Base.establish_connection(db_options)
