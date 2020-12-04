=begin

apiHash = {
  "sumKey" => sumval
  "data" => [
    {
      "keyWeWant1" => "valWeWant1"
    },
    {
      "keyWeWant2" => "valWeWant2"
    }
  ]
}

"http://data.orghunter.com/v1/charitysearch?user_key=91579c7cb9d6cf714d342a63e7d8800e&form990_amount_min=240000000&rows=3000"

"Health - General and Rehabilitative"
"Educational Institutions and Related Activities"
"Not Provided"

259 records left

=end

def populateCharity(url)

  apiCall = GetRequester.new(url)
  parsed = apiCall.parse_json["data"]

  parsed.each do |charity|
    Charity.create(ein: charity["ein"], name: charity["charityName"], category: charity["category"],
    state: charity["state"], accepting_donations: charity["acceptingDonations"])
  end

end

=begin
def populateCharityFinancial
  Charity.all.each do |charity|

  end
end
=end

def categoriesAndCount
  catHash = Hash.new(0)
  Charity.all.each {|charity| catHash[charity.category] += 1}
  catHash
end

def statesAndCount
  catHash = Hash.new(0)
  Charity.all.each {|charity| catHash[charity.state] += 1}
  catHash.sort_by{|k, v| v}.reverse
end

def statesAndCountAR
  Charity.group(:state).count(:state)
end