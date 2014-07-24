class UrlsController < ApplicationController

  before_filter :authenticate_user!

  # GET /urls
  # GET /urls.json
  def index
    @urls = current_user.urls
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # POST /urls.json
  def create

    @url = Url.new(url_params)
    @url.user = current_user
    @url.unique_key = @url.generate_unique_key

    if @url.save
      response = {:status => 'success', :mgs => root_url + 's/' + @url.unique_key}
    else
      response = {:status => 'fail', :mgs => 'Not a valid URL.'}
    end

    respond_to do |format|
      format.json { render json: response }
    end
  end

  # GET /urls//s/:unique_key
  def translate
      # pull the link out of the Database
      @url = Url.where(:unique_key => params[:unique_key]).first

      if @url
        @url.hit_count_increament
        # do a 301 redirect to the destination url
        head :moved_permanently, :location => @url.url
      else
        # if we don't find the shortened link, redirect to the root
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
