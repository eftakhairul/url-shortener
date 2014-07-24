module UrlsHelper
  # generate a url from a url string
  def short_url(unique_key)
    root_url + 's/' + unique_key.to_s
  end
end
