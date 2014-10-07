class ApiController < ApplicationController

  def index
  	@user = User.find(session[:user_id]) 


    @response = HTTParty.get("http://api.worldbank.org/countries/iq/indicators/SP.POP.TOTL?format=json")


    # @all_countries = HTTParty.get("http://api.worldbank.org/country?per_page=300&region=WLD&format=json")

    # @countries =[]

    # i = 0

    # while i < @all_countries[1].size
    # 	@countries << @all_countries[1][i]["iso2Code"]
    # 	i+= 1
    # end


    # def select_country(country)
    # 	country_iso2code = "iq"


    # 	HTTParty.get("http://api.worldbank.org/#{country_iso2code}/#{indicators}/SP.POP.TOTL?format=json")
    # end
    

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

    









#   <%= select_tag "Country", options_for_select(@countries), :id => 'countries',
# :onchange => 'change()' %>

# <%= form_for @country, :url => {:action => "select_country" } do |f| %>
# <input type="text" id="country" placeholder="get value on option select"><br>
# <%= f.submit "Submit" %>
# <%end%>

# <script>
# function change() {
# 	document.getElementById("country").value = document.getElementById("countries").value;
# };

# </script>

end

end
