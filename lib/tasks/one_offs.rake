namespace :one_offs do
  desc "Idempotent tasks to be run once in deployed environments"
  task :all => :environment do |_, args|
    PoliceDistrict.where(timezone: nil).update_all(timezone: 'Pacific Time (US & Canada)')
  end
end
