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
10.times do
  User.create!(
    email: Faker::Internet.unique.email,
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    display_name: Faker::Name.unique.first_name + rand(10).to_s,
    password: "password",
  )
end
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
  "fields name,cover.url,summary; where first_release_date < 946684799; limit 25;"
response = JSON.parse(http.request(request).body)

response.each do |game|
  created = Game.new({ name: game["name"], description: game["summary"] })
  unless game["cover"].nil?
    img_url = "http:" + game["cover"]["url"].gsub("t_thumb", "t_cover_big")
    file = URI.open(img_url)
    created.photo.attach(
      io: file,
      filename: "#{game["id"]}.png",
      content_type: "image/png",
    )
  end
  created.save
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
