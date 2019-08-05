Message.destroy_all
puts 'destroying messages'
User.destroy_all
puts 'destroying users'
Channel.destroy_all
puts 'destroying channels'

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

names = %w(general paris react)
nicknames = %w(Saad Sulav Tina Louisa Daniah Alex Thomas Doug Eugene)

channels = names.map do |name|
  Channel.find_or_create_by(name: name)
end

users = nicknames.map do |nickname|
  User.create(email: "#{nickname.downcase}@me.com", nickname: nickname, password: "secret123")
end

20.times do
  Message.create! user: users.sample, channel: channels.sample, content: Faker::HowIMetYourMother.quote
end

puts 'Channels:'
channels.each do |channel|
  puts "- #{channel.id}: #{channel.name}"
end
