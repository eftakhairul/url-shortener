class UrlsController < ApplicationController

  include UrlsHelper

  #Check authentication everytime
  before_filter :authenticate_user!

  #listing all URLs
  # GET /urls
  # GET /urls.json
  def index
    @urls = current_user.urls
  end


  #Main URL Shortener Page
  # GET /urls/new
  def new
    @url = Url.new
  end

  #Make short url from actual url and send it back as json
  # POST /urls.json
  def create

    @url            = Url.new(url_params)
    @url.user       = current_user
    @url.unique_key = @url.generate_unique_key

    #save data
    if @url.save
      response = {:status => 'success',
                  :mgs    => short_url(@url.unique_key)}
    else
      response = {:status => 'fail',
                  :mgs    => 'Not a valid URL.'}
    end

    #send response
    respond_to do |format|
      format.json { render json: response }
    end
  end

  # Translate short url to actual url
  # GET /urls//s/:unique_key
  def translate
      # pull the link out of the Database
      @url = Url.where(:unique_key => params[:unique_key]).first

      if @url
        @url.hit_count_increament
        # do a 301 redirect to the destination url
        head :moved_permanently, :location => @url.url
      else
        # if shortened link is not found, redirect to the root
        # make this configurable in future versions
        head :moved_permanently, :location => root_url
      end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:url, :unique_key, :hits)
    end
end
