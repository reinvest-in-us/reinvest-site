FactoryBot.define do
  factory :police_district do
    timezone { 'Pacific Time (US & Canada)' }
    sequence :slug do |n|
      "department-#{n}"
    end
    sequence :name do |n|
      "Department #{n}"
    end
  end
end
