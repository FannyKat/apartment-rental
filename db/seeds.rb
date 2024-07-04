# Seed data for users
users = [
  { email: 'user1@owner.com', password: 'password', first_name: 'John', last_name: 'Doe', role: 'owner' },
  { email: 'user2@owner.com', password: 'password', first_name: 'Alice', last_name: 'Johnson', role: 'owner' },
  { email: 'user1@tenant.com', password: 'password', first_name: 'Jane', last_name: 'Smith', role: 'tenant' },
  { email: 'user2@tenant.com', password: 'password', first_name: 'Bob', last_name: 'Brown', role: 'tenant' },
  { email: 'user1@admin.com', password: 'password', first_name: 'Mark', last_name: 'Taylor', role: 'admin' },
  { email: 'user2@admin.com', password: 'password', first_name: 'Linda', last_name: 'Williams', role: 'admin' }
]

users.each do |user_attrs|
  User.create!(user_attrs)
end

puts "Users seeded successfully."

# Seed data for apartments
apartments = [
  { owner_id: User.find_by(email: 'user1@owner.com').id, location: '123 Main St, City', title: 'Cozy Apartment', amenities: 'Furnished, Wifi', number_of_bedrooms: 2, rent_amount: 1500 },
  { owner_id: User.find_by(email: 'user1@owner.com').id, location: '456 Elm St, Town', title: 'Modern Studio', amenities: 'Pool, Gym', number_of_bedrooms: 1, rent_amount: 1200 },
  { owner_id: User.find_by(email: 'user2@owner.com').id, location: '789 Oak St, Village', title: 'Spacious Loft', amenities: 'Terrace, Garage', number_of_bedrooms: 3, rent_amount: 1800 },
  { owner_id: User.find_by(email: 'user2@owner.com').id, location: '101 Pine St, Suburb', title: 'Luxury Condo', amenities: 'Doorman, Gym', number_of_bedrooms: 2, rent_amount: 2000 }
]

apartments.each do |apt_attrs|
  Apartment.create!(apt_attrs)
end

puts "Apartments seeded successfully."

# Seed data for bookings
bookings = [
  { tenant_id: User.find_by(email: 'user1@tenant.com').id, apartment_id: Apartment.first.id, status: 'accepted', message: 'Looking forward to staying here!', start_date: DateTime.now, end_date: DateTime.now + 7.days },
  { tenant_id: User.find_by(email: 'user1@tenant.com').id, apartment_id: Apartment.second.id, status: 'pending', message: 'Checking availability...', start_date: DateTime.now + 10.days, end_date: DateTime.now + 15.days },
  { tenant_id: User.find_by(email: 'user2@tenant.com').id, apartment_id: Apartment.third.id, status: 'accepted', message: 'Can\'t wait!', start_date: DateTime.now + 5.days, end_date: DateTime.now + 12.days },
  { tenant_id: User.find_by(email: 'user2@tenant.com').id, apartment_id: Apartment.fourth.id, status: 'pending', message: 'Is this available?', start_date: DateTime.now + 20.days, end_date: DateTime.now + 27.days }
]

bookings.each do |booking_attrs|
  Booking.create!(booking_attrs)
end

puts "Bookings seeded successfully."

# Seed data for disputes
disputes = [
  { booking_id: Booking.first.id, user_id: Booking.first.tenant_id, description: 'Issue with the cleanliness of the apartment.', status: 'pending' },
  { booking_id: Booking.second.id, user_id: Booking.second.tenant_id, description: 'Owner did not show up for key handover.', status: 'pending' },
  { booking_id: Booking.third.id, user_id: Booking.third.tenant_id, description: 'Appliances not working properly.', status: 'pending' }
]

disputes.each do |dispute_attrs|
  Dispute.create!(dispute_attrs)
end

puts "Disputes seeded successfully."

# Seed data for ownership requests
ownership_requests = [
  { tenant_id: User.find_by(email: 'user1@tenant.com').id, status: 'pending', email: 'requester1@example.com', first_name: 'Requester1', last_name: 'One'},
  { tenant_id: User.find_by(email: 'user2@tenant.com').id, status: 'pending', email: 'requester2@example.com', first_name: 'Requester2', last_name: 'Two'}
]

ownership_requests.each do |request_attrs|
  OwnershipRequest.create!(request_attrs)
end

puts "Ownership requests seeded successfully."

puts "Seed data successfully loaded."
