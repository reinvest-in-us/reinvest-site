namespace :one_offs do
  desc "Idempotent tasks to be run once in deployed environments"
  task :all => :environment do |_, args|
  end
end
