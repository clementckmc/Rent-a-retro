require "net/https"
require "open-uri"
require "faker"

puts "Destroy everything..."
User.destroy_all
Game.destroy_all
Offer.destroy_all
Rental.destroy_all
puts "Destroyed everything!"

puts "Create users..."
location = ["Tokyo-to", "Chiba-ken", "Kanagawa-ken", "Osaka-fu", "Fukuoka-ken"]
10.times do
  first_name = Faker::Name.unique.first_name
  User.create!(
    email: Faker::Internet.unique.email,
    first_name: first_name,
    last_name: Faker::Name.unique.last_name,
    display_name: first_name + rand(10).to_s,
    password: "password",
    location: location.sample
  )
end
User.create!(email: "user1@gmail.com",
  first_name: "User",
  last_name: "One",
  display_name: "User1",
  password: "password",
  location: location.sample)

User.create!(email: "user2@gmail.com",
    first_name: "User",
    last_name: "Two",
    display_name: "User2",
    password: "password",
    location: location.sample)
puts "Created users!"

puts "Create games..."
client_id = ENV["CLIENT_ID"]
access_token = ENV["TOKEN"]

http = Net::HTTP.new("api.igdb.com", 443)
http.use_ssl = true
request_games =
  Net::HTTP::Post.new(
    URI("https://api.igdb.com/v4/games"),
    { "Client-ID" => client_id, "Authorization" => "Bearer #{access_token}" },
  )
request_games.body =
  "fields name,cover.url,summary,first_release_date,genres; where first_release_date < 946684799; limit 500;"
response_games = JSON.parse(http.request(request_games).body)

request_genres =
  Net::HTTP::Post.new(
    URI("https://api.igdb.com/v4/genres"),
    { "Client-ID" => client_id, "Authorization" => "Bearer #{access_token}" },
  )
request_genres.body =
  "fields id,name; limit 500;"
response_genres = JSON.parse(http.request(request_genres).body)

response_games.each do |game|
  if game["genres"]
    genre = response_genres.find { |g| g["id"] == game["genres"][0]}["name"]
  else
    genre = "N/A"
  end
  created = Game.new({ name: game["name"], description: game["summary"], release_date: Time.at(game["first_release_date"].to_i).to_s[0..9], rating: rand(10.0), genre: genre })
  if game["cover"]
    img_url = "http:" + game["cover"]["url"].gsub("t_thumb", "t_cover_big")
    file = URI.open(img_url)
    created.photo.attach(
      io: file,
      filename: "#{game["id"]}.png",
      content_type: "image/png",
    )
    created.save
  end
end
puts "Created games!"

puts "Create offers..."
platforms = ["PC", "Playstation", "Gameboy", "N64", "Super Nintendo"]

10.times do
  Offer.create!(
    {
      user: User.all.sample,
      game: Game.all.sample,
      platform: platforms.sample,
      price: rand(50..100),
    },
  )
end
puts "Created offers!"

10.times do
  Rental.create!(user: User.all.sample, offer: Offer.all.sample, status: "requested", start_date: "15/11/22", due_date: "22/11/22")
end
puts "Created rentals!"
