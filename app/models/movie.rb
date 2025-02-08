class Movie
  include Mongoid::Document
  include Mongoid::Timestamps

  field :imdb_id, type: String
  field :title, type: String
  field :year, type: String
  field :genre, type: String
  field :director, type: String
  field :synopsis, type: String
  field :poster, type: String
  field :comments, type: Array, default: []

  validates :imdb_id, presence: true, uniqueness: true

  has_and_belongs_to_many :favorited_by_users, class_name: 'User'

  def add_comment(user, content)
    comments << { _id: BSON::ObjectId.new, user_name: user.name, content: content, created_at: Time.now.utc }
    save
  end
end
