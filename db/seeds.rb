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
  user = User.new(user_attrs)

  avatar_url = Faker::Avatar.image(size: "100x100", format: "png", set: "set4")

  downloaded_image = URI.open(avatar_url)

  user.avatar.attach(io: downloaded_image, filename: Faker::File.file_name, content_type: 'image/png')

  user.save!
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
  apartment = Apartment.new(apt_attrs)
  retry_count = 0

  begin
    image_url = Faker::LoremFlickr.image(size: "300x300", search_terms: ["hebergement"])

    downloaded_image = URI.open(image_url)
    apartment.image.attach(io: downloaded_image, filename: Faker::File.file_name, content_type: 'image/jpg')

  rescue Socket::ResolutionError => e
    retry_count += 1

    if retry_count <= 3
      Rails.logger.warn("Failed to download image #{e.message}. Retrying...")
      sleep(3)
    else
      Rails.logger.error("Failed to download image. Attempts : #{e.message}.")
      raise
    end
  end

  apartment.save!
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

# Seed data for ownership requests

ownership_requests = []

User.where(role: 'owner').each do |owner|
  ownership_requests << {
    tenant_id: owner.id,
    email: owner.email,
    first_name: owner.first_name,
    last_name: owner.last_name,
    status: "accepted"
  }
end

ownership_requests.each do |ownership_requests_attrs|
  OwnershipRequest.create!(ownership_requests_attrs)
end

puts "OwnershipRequests seeded successfully."
