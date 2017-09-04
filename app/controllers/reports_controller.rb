class ReportsController < ApplicationController
  def index
    @report = Report.new
    @total_count = Report.all.count
  end

  def new
  end

  def create

    @report = Report.new(report_params)

    if @report.save
      flash[:success] = '정상적으로 신고되었습니다.'
      redirect_to root_path
    else
      redirect_to status: 500
    end

  end

  private

  def report_params
    params.require(:report).permit(:url, :description)
  end
end
