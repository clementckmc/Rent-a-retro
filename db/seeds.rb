require 'net/https'
require 'open-uri'
require 'faker'

User.destroy_all
Game.destroy_all

User.create!(email: "fuhajin@gmail.com", first_name: "juri", last_name: "han", display_name: "jurihan", password: "password")
User.create(email: "littlefriend@gmail.com", first_name: "tony", last_name: "montana", display_name: "scarface", password: "password")
User.create(email: "quietlife@gmail.com", first_name: "yoshikage", last_name: "kira", display_name: "killerqueen", password: "password")
User.create(email: "baddad@gmail.com", first_name: "gendo", last_name: "ikari", display_name: "gendopose", password: "password")
User.create(email: "beauty@gmail.com", first_name: "audrey", last_name: "hepburn", display_name: "romanholiday", password: "password")
User.create(email: "pokerface@gmail.com", first_name: "stefani", last_name: "germanotta", display_name: "ladygaga", password: "password")
User.create(email: "illustrious@gmail.com", first_name: "mari", last_name: "makinami", display_name: "zabeasto", password: "password")
User.create(email: "bondvillian@gmail.com", first_name: "elon", last_name: "musk", display_name: "chieftwit", password: "password")
User.create(email: "darkknight@gmail.com", first_name: "bruce", last_name: "wayne", display_name: "batman", password: "password")
User.create(email: "bigguy4u@gmail.com", first_name: "tom", last_name: "hardy", display_name: "bane", password: "password")
User.create(email: "cloudff7r@gmail.com", first_name: "cloud", last_name: "strife", display_name: "cloud", password: "password")
User.create(email: "aerithff7r@gmail.com", first_name: "aerith", last_name: "gainsborough", display_name: "aerith", password: "password")

10.times do
  User.create!(email: Faker::Internet.unique.email, first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, display_name: Faker::Name.unique.first_name + rand(10).to_s, password: "password")
end

client_id = ENV['CLIENT_ID']
access_token = ENV["TOKEN"]

http = Net::HTTP.new('api.igdb.com', 443)
http.use_ssl = true
request = Net::HTTP::Post.new(URI('https://api.igdb.com/v4/games'), {'Client-ID' => client_id, 'Authorization' => "Bearer #{access_token}"})
request.body = 'fields name,cover.url,summary; where first_release_date < 946684799;'
response = JSON.parse(http.request(request).body)

response.each do |game|
  created = Game.new({name: game["name"], description: game["summary"]})
  unless game["cover"].nil?
    img_url = "http:" + game["cover"]["url"].gsub("t_thumb", "t_cover_big")
    file = URI.open(img_url)
    created.photo.attach(io: file, filename: "#{game["id"]}.png", content_type: "image/png")
  end
  created.save
end
