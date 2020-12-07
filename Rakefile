require 'active_record'
require_relative 'app/run.rb'
require_relative 'config/environment.rb'
require_relative 'lib/get_requester.rb'
require_relative 'app/charity_controller.rb'
require_all 'app/models'
require "sinatra/activerecord/rake"


task :environment do
  ENV["ACTIVE_RECORD_ENV"] ||= "development"
  require_relative './config/environment'
end

include ActiveRecord::Tasks
DatabaseTasks.db_dir = 'db'
DatabaseTasks.migrations_paths = 'db/migrate'
seed_loader = Class.new do
  def load_seed
    load "#{ActiveRecord::Tasks::DatabaseTasks.db_dir}/seeds.rb"
  end
end
DatabaseTasks.seed_loader = seed_loader.new
load 'active_record/railties/databases.rake'

task :console => :environment do
  Pry.start
end 

# task :run => :environment do
#   run
# end