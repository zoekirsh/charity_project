require 'active_support/core_ext/numeric/conversions'

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

def nice(aOfA)
  aOfA.map{|i| "#{i[0]}: $#{i[1].to_s(:delimited)}"}
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
  CharityActivity.all.each {|r| actHash[r.activity.activity_name] += 1}
  actHash.sort_by{|k, v| v}.reverse
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

def rank_by_avg_income(state)
  avg_incomes.length.times do |i|
    if avg_incomes[i][0] == state
      return "#{avg_incomes[i][0]} is ranked #{i+1}, with an average income of $#{avg_incomes[i][1].to_s(:delimited)}."
    end
  end
end

#look through each charity, if charity has activity matching param, hash[thatCharitysState] += charityIncome
def total_income_for_activity_by_state(activity)
  actIncHash = Hash.new(0)
  Charity.all.each do |c|
    if c.activities.map{|a| a.activity_name}.include?(activity)
      actIncHash[c.state] += c.income_amount
    end
  end
  actIncHash.sort_by{|k,v| v}.reverse
end

def state_with_highest_income_for(activity)
  nice(total_income_for_activity_by_state(activity)).first
end

def rank_by_income_for_activity_by(state, activity)
  incomeArr = total_income_for_activity_by_state(activity)
  incomeArr.length.times do |i|
    if incomeArr[i][0] == state
      return "#{incomeArr[i][0]} is ranked #{i+1} of #{incomeArr.length}, with income of $#{incomeArr[i][1].to_s(:delimited)} benefitting #{activity}."
    end
  end
  "Sorry, #{activity} not found in #{state}."
end

def sum_of_activity_incomes
  incHash = Hash.new(0)
  Charity.all.each do |c|
    Activity.all.each do |a|
      if c.activities.include?(a)
        incHash[a.activity_name] += c.income_amount
      end
    end
  end
  incHash.sort_by{|k,v| v}.reverse
end

#sum of incomes by activity, 
def percentage_of_income_for(activity)
  incomeArr = sum_of_activity_incomes
  totalIncome = incomeArr.sum{|i| i[1]}
  
  incomeArr.length.times do |i|
    if incomeArr[i][0] == activity
      return "#{((incomeArr[i][1]/totalIncome.to_f)*100).round(2)}%"
    end
  end
end

#misc
def multiple_activities
  Charity.all.select {|c| c.activities.length > 1}.map do |c|
    "#{c.name}-#{c.activities.map {|a| a.activity_name}}"
  end
end