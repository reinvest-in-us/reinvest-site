# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_district(name, slug)
  district = PoliceDistrict.find_or_initialize_by(
    slug: slug,
  )
  district.update(
    name: name,
    fy_2019_policing_budget: rand(900_000..1_200_000_000),
    timezone: 'Pacific Time (US & Canada)'
  )
  meeting = Meeting.create(
    police_district: district,
    event_datetime: Date.today + rand(2..30).days,
    phone_number: "555-123-4567"
  )
  puts "Created or updated district with slug '#{district.slug}'"
end

create_district("San Francisco", "san-francisco")
create_district("Oakland", "oakland")
create_district("Los Angeles", "los-angeles")
create_district("BART", "bart")

user = User.find_or_initialize_by(
  email: 'admin@example.com'
)
user.update(
  password: 'qwerty'
)
puts "Created or updated user with email '#{user.email}'"
