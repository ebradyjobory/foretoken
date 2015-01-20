class ApiController < ApplicationController

  def index
  	@user = User.find(session[:user_id]) 
    @response = HTTParty.get("http://api.worldbank.org/countries/iq/indicators/SP.POP.TOTL?format=json")
    #http://api.worldbank.org/countries/iq/indicators/SP.POP.TOTL?format=json << population
    @time = []
    @data = []
    @historical = {}
    i = 1
    while i < @response[1].size do
       @time << @response[1][i]["date"]
       @data << @response[1][i]["value"]
       @historical["#{@response[1][i]["date"]}"] = @response[1][i]["value"]
       i += 1
    end

    @historical_year = []

    @historical.each do |date, value|	
   	  @historical_year << Forecast.create(:year => date, :value => value)
   	end
  end

end
