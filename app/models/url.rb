class Url
  include Mongoid::Document

  field :url, type: String
  field :unique_key, type: String
  field :hits, type: Integer, default: 0
  field :created_at, :type => Date, default: Date.today

  validates_presence_of :url
  belongs_to :user
end
