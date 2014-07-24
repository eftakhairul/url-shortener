class Url
  include Mongoid::Document
  include Mongoid::Contextual::Aggregable::Mongo

  field :url, type: String
  field :unique_key, type: String
  field :hit_count, type: Integer, default: 0
  field :created_at, :type => Date, default: Date.today


  validates_presence_of :url
  belongs_to :user

  #
  #after_save do |document|
  #  document.update_attributes(url_id: 100000000)
  #  #max_id =  self.find("id" => x).sort({"url_id" => -1}).limit(1).first()
  #  #
  #  #max_id.nil?
  #  #  max_id = 100000000
  #  #
  #  #document.url_id = max_id + 1
  #  #document.update_attributes(first_nameurl_id: max_id)
  #end

  def generate_unique_key
    length = self.url.length
    rand(36**length).to_s(36)
  end

  def hit_count_increament
    self.hit_count = self.hit_count + 1
    self.update
  end
end
