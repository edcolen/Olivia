class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]
  def home
    @places = Place.all
    @markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { place: place }),
        image_url: helpers.asset_url('pink_marker.png')
      }
    end
  end
end
