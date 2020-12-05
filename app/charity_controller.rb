=begin
Just in case...

"http://data.orghunter.com/v1/charitysearch?user_key=91579c7cb9d6cf714d342a63e7d8800e&form990_amount_min=240000000&rows=3000"

=end
def populateHelper(url)
  apiCall = GetRequester.new(url)
  apiCall.parse_json["data"]
end

def populateCharity(url)
  parsed = populateHelper(url)

  parsed.each do |charity|
    Charity.create(ein: charity["ein"], name: charity["charityName"], category: charity["category"],
      state: charity["state"], accepting_donations: charity["acceptingDonations"])
  end

end

def populateCharityFinancial
  partialUrl = "http://data.orghunter.com/v1/charityfinancial?user_key=91579c7cb9d6cf714d342a63e7d8800e&ein="
  Charity.all.each do |charity|
    parsed = populateHelper("#{partialUrl+charity.ein.to_s}")
    charity.update(management_fees: parsed["feesforsrvcmgmt"].to_i,
      legal_fees: parsed["legalfees"].to_i,
      income_amount: parsed["incomeAmount"].to_i)

    # 3.times do |i|
    #   if parsed["activity#{i+1}"]
    #     a1 = Activity.find_or_create_by(activity_name: parsed["activity#{i+1}"])
    #     CharityActivity.create(charity_id: charity.id, activity_id: a1.id)
    #   end
    # end
  end
end


  #Is there a better way to reorder this hash by value?
  def categoriesAndCount
    catHash = Hash.new(0)
    Charity.all.each {|charity| catHash[charity.category] += 1}
    catHash.sort_by{|k, v| v}.reverse
  end

  def x_most_common_categories(x)
    categoriesAndCount.first(x)
  end


  def activitiesAndCount
    actHash = Hash.new(0)
    Activity.all.each {|activity| actHash[activity.activity_name] += 1}
  end
  
  def x_most_common_activities(x)
    activitiesAndCount.first(x)
  end


  def statesAndCount
    stateHash = Hash.new(0)
    Charity.all.each {|charity| stateHash[charity.state] += 1}
    stateHash.sort_by{|k, v| v}.reverse
  end
  
  def x_states_with_most_charities(x)
    statesAndCount.first(x)
  end
  

  
  def charities_in(state)
    Charity.all.select{|charity| charity.state == state}
  end
  
  def charity_names_in(state)
    charities_in(state).map {|c| c.name}.sort
  end

  def charity_categories_in(state)
    catHash = Hash.new(0)
    charities_in(state).each {|c| catHash[c.category] += 1}
    catHash.sort_by{|k,v| v}.reverse
  end

  def charity_activities_in(state)
    activityHash = Hash.new(0)
    charities_in(state).map {|c| c.activities}.each do |a|
      a.length.times do |i|
        activityHash[a[i].activity_name] +=1
      end
    end
    activityHash.sort_by{|k, v| v}.reverse
  end




  def total_income_per_state
    incomeHash = Hash.new(0)
    Charity.all.each {|c| incomeHash[c.state] += c.income_amount}
    incomeHash.sort_by{|k,v| v}.reverse
  end

  #will need to sum income amounts grouped by state
  #then display list of states with income amounts/number of nonprofits
  def avg_incomes
    incomeTotals = total_income_per_state
    charityCounts = statesAndCount

    avgHash = {}
    incomeTotals.each do |i|
      charityCounts.each do |c|
        if i[0] == c[0]
          avgHash[i[0]] = i[1]/c[1]
        end
      end
    end
    avgHash.sort_by{|k,v| v}.reverse
  end
