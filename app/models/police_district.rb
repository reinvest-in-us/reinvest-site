class PoliceDistrict < ApplicationRecord
  validates_presence_of :name
  validates :slug, uniqueness: true, format: { with: /\A[a-z0-9\-]+\Z/ }, allow_blank: true

  after_validation :set_slug

  include ActionView::Helpers::NumberHelper

  def readable_budget
    if fy_2019_policing_budget.nil?
      '---'
    elsif fy_2019_policing_budget >= 1_000_000
      number_with_delimiter((fy_2019_policing_budget.to_f / 1_000_000).round)
    else
      (fy_2019_policing_budget.to_f / 1_000_000).round(2).to_s
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
