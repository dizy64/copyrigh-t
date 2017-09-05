class Report < ApplicationRecord
  validates :url, presence: true, url: true

  scope :today, -> { where 'created_at >= ?', Time.zone.now.beginning_of_day }
  scope :yesterday, -> {
    where 'created_at >= ? and ? > created_at', Time.zone.now.beginning_of_day - 1.day, Time.zone.now.beginning_of_day
  }

  def self.arrange
    result = []
    self.pluck(:url).each do |u|
      result << { url: u, count: self.where("url LIKE '#{ u.split('&').first }%'").count }
    end
    result
  end
  
end
