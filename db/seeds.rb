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
request =
  Net::HTTP::Post.new(
    URI("https://api.igdb.com/v4/games"),
    { "Client-ID" => client_id, "Authorization" => "Bearer #{access_token}" },
  )
request.body =
  "fields name,cover.url,summary,first_release_date; where first_release_date < 946684799; limit 25;"
response = JSON.parse(http.request(request).body)

response.each do |game|
  created = Game.new({ name: game["name"], description: game["summary"], release_date: Time.at(game["first_release_date"].to_i).to_s[0..9], rating: rand(10.0) })
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
      price: rand(500..1000),
    },
  )
end
puts "Created offers!"

10.times do
  Rental.create!(user: User.all.sample, offer: Offer.all.sample, status: "requested", start_date: "15/11/22", due_date: "22/11/22")
end
puts "Created rentals!"
