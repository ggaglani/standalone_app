require 'rubygems'
require 'bundler/gem_tasks'
require 'rake'
require 'yaml'
require 'logger'
require 'active_record'


#ActiveRecord database tasks.
include ActiveRecord::Tasks

class Seeder
  def initialize(seed_file)
    @seed_file = seed_file
  end

  def load_seed
    raise "Seed file '#{@seed_file}' does not exist" unless File.file?(@seed_file)
    load @seed_file
  end
end


root = File.expand_path '..', __FILE__
DatabaseTasks.env = ENV['ENV'] || 'development'
DatabaseTasks.database_configuration = YAML.load(File.read(File.join(root, 'config/database.yml')))
DatabaseTasks.db_dir = File.join root, 'db'
DatabaseTasks.fixtures_path = File.join root, 'test/fixtures'
DatabaseTasks.migrations_paths = [File.join(root, 'db/migrate')]
DatabaseTasks.seed_loader = Seeder.new File.join root, 'db/seeds.rb'
DatabaseTasks.root = root

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
  ActiveRecord::Base.logger = ActiveSupport::Logger.new("#{root}/log/scp_data_store.log")
end

load 'active_record/railties/databases.rake'

Dir.glob("#{Dir.pwd}/lib/tasks/*.rake") do |rakee|
  load rakee
end

