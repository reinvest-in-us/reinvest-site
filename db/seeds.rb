# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_district(name, slug, has_future_meeting)
  district = PoliceDistrict.find_or_initialize_by(
    slug: slug,
  )
  district.update!(
    name: name,
    total_police_department_budget: rand(900_000..1_200_000_000),
    timezone: 'Pacific Time (US & Canada)',
    total_general_fund_budget: 1_000_000_000,
    total_police_paid_from_general_fund_budget: 420_000_000,
    decision_makers_text: "A budget proposal is made by the mayor, advised by the Budget Advisory Committee.\nSee below for elected offficals.",
    elected_officials_contact_link: "www.google.com"
  )

  meeting_date = has_future_meeting ? (Date.today + rand(2..30).days) : Date.yesterday
  Meeting.create!(
    police_district: district,
    event_datetime: meeting_date,
    video_link: "http://example.com/meeting",
    how_to_comment: "Call 1-800-555-5555 to join the meeting.\nPress * 9 to raise your hand to speak.\nWait until you are unmuted and begin speaking.\n",
    agenda_link: "www.google.com",
    agenda_details: "Zero Tolerance Policy For Racist Practices, OPD Spotshotter Contract",
    about: "This meeting is very important.\nBe sure to call in."
  )

  create_official(district, 1, "Sandra Lee Fewer", "District 1", "Nov. 2022")
  create_official(district, 2, "Catherine Stefani", "District 2", "Nov. 2022")
  create_official(district, 3, "Aaron Peskin", "District 3", "Nov. 2022")
  create_official(district, 4, "Gordon Mar", "District 4", "Nov. 2022")
  create_official(district, 5, "Dean Preston", "District 5", "Nov. 2022")

  puts "Created or updated district with slug '#{district.slug}'"
end

def create_official(district, list_rank, name, position, reelection_date)
  ElectedOfficial.create!(
    police_district: district,
    list_rank: list_rank,
    name: name,
    position: position,
    reelection_date: reelection_date
  )
end

create_district("San Francisco", "san-francisco", true)
create_district("Oakland", "oakland", true)
create_district("Los Angeles", "los-angeles", true)
create_district("BART", "bart", false)

user = User.find_or_initialize_by(
  email: ENV.fetch('SEED_USER_EMAIL', 'admin@example.com')
)
user.update(
  password: ENV.fetch('SEED_USER_PASSWORD', 'qwerty')
)
puts "Created or updated user with email '#{user.email}'"
