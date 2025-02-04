class Movie
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :year, type: String
  field :genre, type: String
  field :director, type: String
  field :synopsis, type: String
  field :user_comment, type: String

  validates :title, presence: true
  validates :year, presence: true
  validates :genre, presence: true
  validates :director, presence: true
  validates :synopsis, presence: true
end
