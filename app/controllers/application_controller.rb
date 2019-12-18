class ApplicationController < ActionController::Base
  def default_url_options
  { host: ENV["www.epicenter.live"] || "localhost:3000" }
  end
end
