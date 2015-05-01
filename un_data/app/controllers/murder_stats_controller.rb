class MurderStatsController < ActionController::Base
  def index
    @stats = MurderStat.all
    if params[:country_name].present?
      @stats = @stats.where(country: Country.find_by_name(params[:country_name]))
    end
    if params[:year].present?
      @stats = @stats.where(year: params[:year])
    end
    render json: @stats, each_serializer: MurderStatSerializer
  end
end
