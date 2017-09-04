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
      flash[:error] = '신고가 접수되지 않았습니다. URL을 다시 확인해주세요.'
      render :index
    end

  end

  private

  def report_params
    params.require(:report).permit(:url, :description)
  end
end
