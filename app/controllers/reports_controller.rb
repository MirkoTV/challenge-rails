class ReportsController < ApplicationController
  def index
    @reports = params[:tags].blank?\
      ? Profile.all
      : Profile.joins(:repositories).where('"repositories"."tags" LIKE (?)', "%#{params[:tags]}%").group(:profile_id)

    respond_to do |format|
      format.html
      format.json { render json: @reports, each_serializer: ReportProfileSerializer }
    end
  end

  def reports_external
    render json: ReportService.new.reports
  end
end
