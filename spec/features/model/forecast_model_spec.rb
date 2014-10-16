require 'spec_helper'

RSpec.describe Forecast do

  context "Forecast model calculation" do

    it "performs calculations successfully" do

      project = Project.create(:name => 'testing')
      project.forecasts = Forecast.create([{:year => 1867, :value => 2203},
      							   {:year => 1868, :value => 2360},
      							   {:year => 1869, :value => 2254},
      							   {:year => 1870, :value => 2165},
      							   {:year => 1871, :value => 2024}])


      							   
	# expect(project.forecasts[0].xxbar.to_f).to be_within(0.3).of(1.8)
 #      expect(project.forecasts[1].xxbar.to_f).to be_within(0.3).of(158.8)
 #      expect(project.forecasts[2].xxbar.to_f).to be_within(0.3).of(52.9)
 #      expect(project.forecasts[3].xxbar.to_f).to be_within(0.3).of(-36.2)
 #      expect(project.forecasts[4].xxbar.to_f).to be_within(0.3).of(-177.2)

 #      expect(project.forecasts[0].ttbar.to_f).to be_within(0).of(-2)
 #      # expect(forecasts[1].ttbar.to_f).to be_within(0).of(-1)
 #      expect(project.forecasts[2].ttbar.to_f).to be_within(0).of(0)
 #      expect(project.forecasts[3].ttbar.to_f).to be_within(0).of(1)
 #      expect(project.forecasts[4].ttbar.to_f).to be_within(0).of(2)

 #      expect(project.forecasts[0].xxbar_ttbar.to_f).to be_within(0.5).of(-3.6)
 #      expect(project.forecasts[1].xxbar_ttbar.to_f).to be_within(0.5).of(-158.8)
 #      expect(project.forecasts[2].xxbar_ttbar.to_f).to be_within(0.5).of(0)
 #      expect(project.forecasts[3].xxbar_ttbar.to_f).to be_within(0.5).of(-36.2)
 #      expect(project.forecasts[4].xxbar_ttbar.to_f).to be_within(0.5).of(-354.4)

 #      expect(project.forecasts[0].ttbar_sq.to_f).to be_within(0.5).of(4)
 #      expect(project.forecasts[1].ttbar_sq.to_f).to be_within(0.5).of(1)
 #      expect(project.forecasts[2].ttbar_sq.to_f).to be_within(0.5).of(0)
 #      expect(project.forecasts[3].ttbar_sq.to_f).to be_within(0.5).of(1)
 #      expect(project.forecasts[4].ttbar_sq.to_f).to be_within(0.5).of(4)

      # expect(project.forecasts[0].xhat.to_f).to be_within(0.5).of(2311.8)
      # expect(project.forecasts[1].xhat.to_f).to be_within(0.5).of(2256.5)
      # expect(project.forecasts[2].xhat.to_f).to be_within(0.5).of(2201.2)
      # expect(project.forecasts[3].xhat.to_f).to be_within(0.5).of(2145.9)
      # expect(project.forecasts[4].xhat.to_f).to be_within(0.5).of(2090.4)

      # expect(project.forecasts[0].x_xhatsq.to_f).to be_within(0.5).of(11837.44)
      # expect(project.forecasts[1].x_xhatsq.to_f).to be_within(0.5).of(10712.25)
      # expect(project.forecasts[2].x_xhatsq.to_f).to be_within(0.5).of(2787.84)
      # expect(project.forecasts[3].x_xhatsq.to_f).to be_within(0.5).of(364.81)
      # expect(project.forecasts[4].x_xhatsq.to_f).to be_within(0.5).of(4435.56)

      
      # expect(project.forecasts[0].xhat_xbarsq.to_f).to be_within(0.5).of(12232.36)
      # expect(project.forecasts[1].xhat_xbarsq.to_f).to be_within(0.5).of(3058.09)
      # expect(project.forecasts[2].xhat_xbarsq.to_f).to be_within(0.5).of(0)
      # expect(project.forecasts[3].xhat_xbarsq.to_f).to be_within(0.5).of(3058.09)
      # expect(project.forecasts[4].xhat_xbarsq.to_f).to be_within(0.5).of(12232.36)

      # project.forecasts.each do |f|
       #   expect(project.forecasts.last.mean.to_f).to eq(2201.2)
      	# expect(project.forecasts.last.b1.to_f).to eq(-55.3)
      	# expect(project.forecasts.last.tbar.to_f).to eq(3)
      	# expect(project.forecasts.last.b0.to_f).to be_within(0.5).of(2367.1)

      # end     
    end
  end
end
