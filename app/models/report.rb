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

  def self.to_excel_file(filename = nil)
    p = Axlsx::Package.new
    wb = p.workbook
    filename = Date.yesterday.strftime('%Y%m%d') if filename.nil?

    wb.add_worksheet(name: '중복 제거') do |sheet|
      sheet.add_row ['URL', '신고 수']
      self.arrange.each do |data|
        sheet.add_row [data[:url], data[:count]]
      end
    end

    wb.add_worksheet(name: '전체') do |sheet|
      sheet.add_row %w[URL 설명]
      self.all.each do |data|
        sheet.add_row [data.url, data.description]
      end
    end

    p.serialize "#{ filename }.xlsx"
  end
  
end
