class Url
  include Mongoid::Document
  include Mongoid::Contextual::Aggregable::Mongo

  field :url, type: String
  field :unique_key, type: String
  field :hit_count, type: Integer, default: 0
  field :created_at, :type => Date, default: Date.today

  belongs_to :user

  index({ unique_key: 1 }, { unique: true })

  URL_PROTOCOL_HTTP = "http://"

  REGEX_HTTP_URL = /^\s*(http[s]?:\/\/)?[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\s*$/i
  REGEX_LINK_HAS_PROTOCOL = Regexp.new('\Ahttp:\/\/|\Ahttps:\/\/', Regexp::IGNORECASE)

  validates_presence_of :url
  validates_format_of :url, :multiline => true, :with => REGEX_HTTP_URL

  before_validation :clean_destination_url, :on => :create



  #Generate the unique key
  #Used very simple ALgo
  def generate_unique_key

    # @TODO:need to update the algo. Right now it's very simple algo
    length = self.url.length
    rand(36**length).to_s(36)
  end

   # Ensuring the url starts with it protocol
   def clean_destination_url
     if !self.url.blank? and self.url !~ REGEX_LINK_HAS_PROTOCOL
       self.url.insert(0, URL_PROTOCOL_HTTP)
     end
   end

  #Increament by 1 when URL is hit
  def hit_count_increament
    self.hit_count = self.hit_count + 1
    self.update
  end
end
