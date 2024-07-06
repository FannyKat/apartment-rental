require 'faker'

# Seed data for users

users = [{
  email: 'user@admin.com',
  password: 'password',
  first_name: 'Linda',
  last_name: 'Williams',
  role: 'admin'
}]

10.times do
  users << {
    email: Faker::Internet.unique.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    role: ['owner', 'tenant'].sample,
  }
end

users.each do |user_attrs|
  User.create!(user_attrs)
end

puts "Users seeded successfully."

# Seed data for apartments
apartments = []

User.where(role: 'owner').each do |owner|
  3.times do
    apartments << {
      owner_id: owner.id,
      location: Faker::Address.full_address,
      title: Faker::Lorem.words(number: 2).join(' '),
      amenities: Faker::Lorem.words(number: 3).join(', '),
      number_of_bedrooms: rand(1..5),
      rent_amount: rand(1000..3000),
    }
  end
end

image_files = Dir.glob('public/apartment_images/*.jpg')

apartments.each do |apt_attrs|
  @apartment = Apartment.new(apt_attrs)
  @apartment.image.attach(io: File.open(image_files.sample), filename: Faker::File.file_name, content_type: 'image/jpg')
  @apartment.save!
end

puts "Apartments seeded successfully."

# Seed data for bookings

bookings = []

User.where(role: 'tenant').each do |tenant|
  3.times do
    bookings << {
      tenant_id: tenant.id,
      apartment_id: Apartment.all.sample.id,
      message: Faker::Markdown.emphasis,
      status: 'pending',
      start_date: Faker::Date.forward(days: 30),
      end_date: Faker::Date.forward(days: 60),
    }
  end
end

bookings.each do |booking_attrs|
  Booking.create!(booking_attrs)
end

puts "Bookings seeded successfully."
