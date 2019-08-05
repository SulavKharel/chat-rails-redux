class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates :content, presence: true

  after_create :broadcast_message

  def as_json(options = {})
    nickname = user.nickname.nil? ? user.email.match(/[^@]+/)[0] : user.nickname
    {
      id: id,
      author: nickname,
      content: content,
      created_at: created_at,
      channel: channel_name
    }
  end

  private

  def broadcast_message
    ActionCable.server.broadcast("channel_#{channel_name}", self)
  end
end
