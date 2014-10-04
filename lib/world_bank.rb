require 'world_bank'

  WorldBank::Source.all.fetch       # =>  ['Doing Business', 'Something Else'...]
                                    #        array of 16 sources of information the bank used

  WorldBank::IncomeLevel..all.fetch # =>  { HIC: 'High Income', HPC: 'Heavily Indebted Poor Countries (HIPC)'...}
                                    #       hash of 9 income levels the bank assigns

  WorldBank::LendingType.all.fetch  # =>  [ { id: 'IBD', value: 'IBRD' }... ] an array of key: value pairs of
                                    #        the 4 lending types

  WorldBank::Topic.all.fetch        # =>  the 18 high level topics that indicators are grouped into

  WorldBank::Region.all.fetch       # =>  returns all the regions the World Bank can classify a country as

  WorldBank::Country.all.fetch      # =>  returns all countries the World Bank tracks

  WorldBank::Indicator.all.fetch    # =>  returns all the indicators the World Bank uses

  WorldBank::Indicator.featured     # =>  returns the featured indicators

  WorldBank::Topic.all.fetch        # =>  returns all the topics the World Bank catagorizes its indicators into
