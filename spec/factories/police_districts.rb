FactoryBot.define do
  factory :police_district do
    timezone { 'Pacific Time (US & Canada)' }
    sequence :slug do |n|
      "department-#{n}"
    end
    sequence :name do |n|
      "Department #{n}"
    end
    total_police_department_budget { 1000000 }
  end
end
