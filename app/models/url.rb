class Url
  include Mongoid::Document

  field :url, type: String
  field :unique_key, type: String
  field :url_id, type: Integer
  field :hits, type: Integer, default: 0
  field :created_at, :type => Date, default: Date.today

  validates_presence_of :url
  belongs_to :user


  after_save do |document|
    max_id =  self.max(:url_id)
    document.url_id = max_id + 1
    document.update_attributes(first_nameurl_id: max_id)
  end

  def generate_unique_key
    max_id = self.max(:url_id)
    max_id.to_s(36)
  end
end
