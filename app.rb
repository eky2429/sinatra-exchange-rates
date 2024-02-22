require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  ctx = OpenSSL::SSL::SSLContext.new
  ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE


  #api_url = "http://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATES_KEY")}"
  api_url = "http://api.exchangerate.host/list?access_key=4eb345ecbefe16b7159612f18206159b"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url,  :ssl_context => ctx)
  pp raw_data

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

  parsed_data

  #   currencies = parsed_data.fetch("currencies")
  #   other_elements = "<ul>"
  #   currencies.each do
  #     |key|
  #     other_elements += "<li> Convert 1 #{key} to ...</li>"
  #   end
  #   other_elements += "</ul>"
  # end
end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  # some more code to parse the URL and render a view template
end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
end
