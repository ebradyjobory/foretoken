class ForecastApisController < ApplicationController
	
  # respond_to :html, :json
    
  #skip_before_action :verify_authenticity_token

  before_action :confirm_logged_in
  before_action :set_project
  before_action :add_user_email
  before_action :check_value, :only => [:index]
  before_action :input

  # def show
  #   @country = params[:country]
  #   @indicator = params[:indicator]
  #   respond_to do |format|
  #     format.js { render 'variables' } 
  #  end
  # end

  def index 
   # @forecast_url = "http://api.worldbank.org/countries/usa/indicators/SP.POP.TOTL?date=1990:2013&?per_page=20000&format=json"
    @forecast_apis = @project_api.forecast_apis
    @future_apis = @project_api.future_apis
    @current_user = @project_api.user
    @forecast_api = ForecastApi.new
    @future_api = FutureApi.new
  
    total_fcast_api_years = []
    total_future_api_years = []
    total_fcast_api_values = []
    total_future_api_values = []
    values = []
    times = []
    @forecast_apis.each do |forecast|
      total_fcast_api_years << forecast.forecast_api_year
      total_fcast_api_values << forecast.forecast_api_value
      @values = values << forecast.forecast_api_value
      @times = times << forecast.time
      @b1   = forecast.b1
      @tbar = forecast.tbar
      @b0   = forecast.b0
    end
    # Calculating total years and values for current project
     total_fcast_years = []
     total_future_years = []
     total_fcast_values = []
     total_future_values = []
     values = []
     times = []
     @project_api.forecast_apis.each do |i|
        total_fcast_years << i.forecast_api_year
        total_fcast_values << i.forecast_api_value
        @values = values << i.forecast_api_value
        @times = times << i.time
     end
    @future_apis.each do |i|
      total_future_api_years << i.future_api_year
      total_future_api_values << i.forecasted
    end
    @total_years = total_fcast_api_years.reverse + total_future_api_years
    @total_values = total_fcast_api_values + total_future_api_values
    @forecasted = total_future_api_values
    @future_years = total_future_api_years

    # Calculating regression line to be presented on chart
    regression = []
    @times.each do |time|
      regression <<  @b0 + (@b1 * time)
    end
    @regression = regression

  end

  def new
    @project_api = ProjectApi.find(params[:project_api_id])
    @forecast_api = @project_api.forecast_apis.new
  end

  def create
    @project_api = ProjectApi.find(params[:project_api_id])

    @inputs = @project_api.forecast_apis.new(params_forecast_api)
    if @inputs.start_date.nil? || @inputs.end_date.nil?
      !@input.save #don't save the object
    else
      # @inputs.save
         @country = @inputs.country 
         @indicator = @inputs.indicator
         @start = @inputs.start_date
         @end = @inputs.end_date

         # 1-convert the country to its IsoCode
         @country_iso_hash.each do |country, code|
            if country == @country
              @iso_code = @country_iso_hash[country]
            end
         end
         # 2-convert the indicator to its id
          @indicator_code =""
          @indicator_id_hash.each do |indicator, id|
            if indicator == @indicator 
              @indicator_code << @indicator_id_hash[indicator]
            end
          end

           # 3-insert the given parameters into the url
           # @forecast_url = HTTParty.get("http://api.worldbank.org/countries/usa/indicators/SP.POP.TOTL?date=1990:2013&?per_page=20000&format=json")
           @forecast_url = HTTParty.get("http://api.worldbank.org/countries/#{@iso_code}/indicators/#{@indicator_code}?date=#{@start}:#{@end}&?per_page=200&format=json")
           # 4-return data (time and value) from the url
            if @forecast_url[0]["total"] == 0
              flash[:error] = "Not enough data available. Please change your searching criteria."
              render('new')
              # redirect_to user_project_api_forecast_apis_path(:user_id => session[:user_id], :project_api_id => @project_api.id)
            else
              # @forecast_url_reverse =  Hash[@forecast_url[1].to_a.map {|x| x = x.reverse}]

            i = 0 
            while i < @forecast_url[1].size
                @forecast_api = @project_api.forecast_apis.new(:forecast_api_year => @forecast_url[1][i]["date"], 
                                                               :forecast_api_value => @forecast_url[1][i]["value"] )
                @forecast_api.save
                i += 1
            end
         redirect_to user_project_api_forecast_apis_path(:user_id => session[:user_id], :project_api_id => @project_api.id)
    	 end
    end
  end

  def edit
  	@forecast_api = ForecastApi.find(params[:id])
    @forecast_apis = @project.forecast_apis
    @current_user = @project.user
  end

  def update
    @forecast_api = ForecastApi.find(params[:id])
    if @forecast_api.update_attributes(params_forecast)
      flash[:notice] = "Data was updated successfully."
      # @forecasts = @project.forecasts
      # @current_user = @project.user

      respond_with @forecast_api
      # redirect_to user_project_forecasts_path(@forecast.project.user.id, @forecast.project.id)
    else
      # render('edit')
    end
  end

  # def delete
  #   @forecast = Forecast.find(params[:id])
  # end

  def destroy
    @forecast_api = ForecastApi.find(params[:id])
    # respond_to do |format|
    @forecast_api.destroy
    flash[:notice] = "Data deleted successfully."
    #     format.html { redirect_to user_project_forecasts_path(:user_id => session[:user_id],  
    #                                           :project_id => @project.id)}
    #     format.json { head :no_content }
    #     format.js   { render :layout => false }
    #   else
    # # redirect_to(:action => 'index', :project_id => @project.id)
    #   end
    end

  private

  def set_project
  	if params[:project_api_id]
  		@project_api = ProjectApi.find(params[:project_api_id])
  	end	
  end

  def check_value
    if @project_api.forecast_apis.empty?
      @times = [1, 1]
      @b1 = 1
      @b0 = 1
      # redirect_to(:action => 'new', :project_id => @project.id)
    end
  end

  def input

    # Api all Countries
    @countries_hash = HTTParty.get("http://api.worldbank.org/country?per_page=500&format=json")
    # Api all indicators
    @indicators_hash = HTTParty.get("http://api.worldbank.org/indicators/?format=json&per_page=100")
    
    @countries = []
    @iso = []
    @country_iso = []

    @indicators = []
    @id = []
    @indicator_id = []

    i = 0
    while i < @countries_hash[1].size
      @countries << @countries_hash[1][i]["name"]
      @country_iso << @countries_hash[1][i]["name"]
      @iso << @countries_hash[1][i]["iso2Code"] 
      @country_iso << @countries_hash[1][i]["iso2Code"]
      i+= 1
    end
    @country_iso_hash = Hash[*@country_iso] #{"Aruba"=>"AW", "Afghanistan"=>"AF",..}

    # Indicators
    i = 0
    while i < @indicators_hash[1].size
      @indicators << @indicators_hash[1][i]["name"]
      @indicator_id << @indicators_hash[1][i]["name"]
      @iso << @indicators_hash[1][i]["id"] 
      @indicator_id << @indicators_hash[1][i]["id"]
      i+= 1
    end
    @indicator_id_hash = Hash[*@indicator_id]
    # i = 0
    # while i < @indicators_hash[1].size
    #   @indicators << @indicators_hash[1][i]["name"]
    #   i+= 1
    # end   
  end

  def params_forecast_api
  	params.require(:forecast_api).permit(:forecast_api_year, :forecast_api_value, 
                                         :country, :indicator, :start_date, :end_date)	
  end


end

