FactoryBot.define do
  factory :meeting do
    police_district
    how_to_comment { 'how to comment' }
  end
end
