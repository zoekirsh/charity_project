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

=end

def populateCharity(url)

  apiCall = GetRequester.new(url)

  apiCall.parse_json["data"].each do |charity|

  end

end