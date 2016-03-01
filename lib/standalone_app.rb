require 'rubygems'
require 'bundler/gem_tasks'
require 'rake'
require 'yaml'
require 'logger'
require 'active_support'
require 'active_support/time_with_zone'
require 'active_record'
require 'mysql2'
require "standalone_app/version"

unless defined?(DatabaseTasks)
  include ActiveRecord::Tasks
end

def root
  @root ||= File.expand_path "../..", __FILE__
end

#Require the model files here...
require "#{root}/app/models/sample"

# ActiveRecord Settings
DatabaseTasks.env = ENV['ENV'] || 'development'

DatabaseTasks.database_configuration = YAML.load_file File.join(root, 'config/database.yml')
ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
ActiveRecord::Base.logger = ActiveSupport::Logger.new(File.open("#{root}/log/standalone_app.log", 'a'))