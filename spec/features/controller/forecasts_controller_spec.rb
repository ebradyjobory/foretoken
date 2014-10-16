require 'spec_helper'

describe ForecastsController do

  describe "Math in Forecasts#Create" do
    it "calculate mean correctly" do
      project = Project.create(:name => 'testing')
      project.forecasts = Forecast.create([{:year => 1867, :value => 2203},
                       {:year => 1868, :value => 2360},
                       {:year => 1869, :value => 2254},
                       {:year => 1870, :value => 2165},
                       {:year => 1871, :value => 2024}])

      expect(project.forecasts.last.mean.to_f).to eq(2201.2)

     

      
      







    end
  end


end