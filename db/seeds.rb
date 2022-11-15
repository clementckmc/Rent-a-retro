require 'net/https'
require 'open-uri'

User.destroy_all
Game.destroy_all

User.create(email: "fuhajin@gmail.com", first_name: "juri", last_name: "han", display_name: "jurihan")
User.create(email: "littlefriend@gmail.com", first_name: "tony", last_name: "montana", display_name: "scarface")
User.create(email: "quietlife@gmail.com", first_name: "yoshikage", last_name: "kira", display_name: "killerqueen")
User.create(email: "baddad@gmail.com", first_name: "gendo", last_name: "ikari", display_name: "gendopose")
User.create(email: "beauty@gmail.com", first_name: "audrey", last_name: "hepburn", display_name: "romanholiday")
User.create(email: "pokerface@gmail.com", first_name: "stefani", last_name: "germanotta", display_name: "ladygaga")
User.create(email: "illustrious@gmail.com", first_name: "mari", last_name: "makinami", display_name: "zabeasto")
User.create(email: "bondvillian@gmail.com", first_name: "elon", last_name: "musk", display_name: "chieftwit")
User.create(email: "darkknight@gmail.com", first_name: "bruce", last_name: "wayne", display_name: "batman")
User.create(email: "bigguy4u@gmail.com", first_name: "tom", last_name: "hardy", display_name: "bane")
User.create(email: "cloudff7r@gmail.com", first_name: "cloud", last_name: "strife", display_name: "cloud")
User.create(email: "aerithff7r@gmail.com", first_name: "aerith", last_name: "gainsborough", display_name: "aerith")

client_id = "0dsiqx7nh6ljalvj1pev66afrkfu7w"
access_token = "6mv7nk0h2ty0oqo2y3mx3mifbjye7q"

http = Net::HTTP.new('api.igdb.com', 443)
http.use_ssl = true
request = Net::HTTP::Post.new(URI('https://api.igdb.com/v4/games'), {'Client-ID' => client_id, 'Authorization' => 'Bearer 6mv7nk0h2ty0oqo2y3mx3mifbjye7q'})
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
