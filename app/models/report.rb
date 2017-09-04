class Report < ApplicationRecord
  validates :url, presence: true, url: true
end
