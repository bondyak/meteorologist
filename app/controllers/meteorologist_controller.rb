require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================

    @url_google = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address_without_spaces

    @parsed_data_google = JSON.parse(open(@url_google).read)

    @lat = @parsed_data_google["results"][0]["geometry"]["location"]["lat"]

    @lng = @parsed_data_google["results"][0]["geometry"]["location"]["lng"]

    @api_key = "4e4a95b571f4498fd72dc87fb461831d"
    @url_forecast = "https://api.darksky.net/forecast/" + @api_key + "/" + @lat.to_s + "," + @lng.to_s

    @parsed_data_forecast = JSON.parse(open(@url_forecast).read)

    @current_temperature = @parsed_data_forecast["currently"]["temperature"]

    @current_summary = @parsed_data_forecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_data_forecast["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_data_forecast["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_data_forecast["daily"]["summary"]


    render("meteorologist/street_to_weather.html.erb")
  end
end
