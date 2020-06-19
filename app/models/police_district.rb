class PoliceDistrict < ApplicationRecord
  TIME_ZONE_OPTIONS = [
    'Pacific Time (US & Canada)'
  ].freeze # supported valid timezones (from rake:time:zones[US] )

  validates_presence_of :name
  validates :slug, uniqueness: true, format: { with: /\A[a-z0-9\-]+\Z/ }, allow_blank: true
  validates :timezone, presence: true, inclusion: { in: TIME_ZONE_OPTIONS }

  has_many :meetings
  has_many :elected_officials

  after_validation :set_slug

  include ActionView::Helpers::NumberHelper

  def readable_budget
    return '---' if fy_2019_policing_budget.nil?

    number_to_human(fy_2019_policing_budget,format:'%n%u',precision: 4, units:{thousand:'K',million:'M',billion:'B'})
  end

  def next_meeting
    @next_meeting ||= meetings.where('event_datetime > ?', Time.zone.now - 8.hours).order('event_datetime').limit(1).first
  end

  def more_funding_than
    [
      [law_enforcement_gets_more_than_1, law_enforcement_gets_more_than_1_dollars],
      [law_enforcement_gets_more_than_2, law_enforcement_gets_more_than_2_dollars],
      [law_enforcement_gets_more_than_3, law_enforcement_gets_more_than_3_dollars],
    ]
    .filter do |pair|
      pair.all?(&:present?)
    end
    .map do |f|
      {name: f[0], amount: f[1]}
    end
  end

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = (slug || name.to_s.parameterize)
  end
end
