# Apartment Rental Application

## Project Overview

This application allows users to browse apartments available for rent, create tenant accounts to request bookings based on their preferences, and manage their rental activities. Additionally, users can apply to become apartment owners, with admin approval granting them the ability to list properties for rent.

## Main Features

- **Tenant Role**

  - **Account Creation**: Users can sign up as tenants.
  - **Booking Requests**: Tenants can request to book apartments based on their search criteria.
  - **Booking Management**: Tenants can view their booking requests and their statuses.
  - **Search Functionality**: Tenants can search for apartments based on location, price range, and number of bedrooms.

- **Owner Role**

  - **Ownership Application**: Users can apply to become apartment owners by sending request to admin with their identity card.
  - **Property Listing**: Owners, once approved, can list their apartments for rent.
  - **Booking Approval**: Owners can **approve**, **reject** or **leave pending** any bookings requests.
  - **Dispute Management**: Owners can raise disputes during the booking period, managed by the admin.
  - **Role Switching**: Owners can easily switch between Tenant and Owner modes.

- **Admin Role**

  - **Administrative Privileges**: Admins can approve ownership requests, manage user accounts, and resolve disputes.
  - **Role-based Access**: Admins have access to all functionalities across the platform for support actions.

- **Multilingual Support**

  - **Language Translation**: The entire site can be translated into English or French with a single click.

## Development Tools

This application was built using Ruby on Rails and leverages the following gems:

- **Devise**: User authentication and role management.
- **Pundit**: Authorization policies and role-based access control.
- **rails-i18n**: Internationalization support.
- **rails_admin**: Admin interface to manage application data.
- **image_processing**: Processing and uploading images.
- **bulma-rails**: Bulma CSS framework.
- **aasm**: State machine management
- **Faker**: Generating fake data in the seeds file.

## Schema ERD

Entity-Relationship Diagram (ERD) representing the database structure of the Apartment Rental Application:

![ERD](https://github.com/user-attachments/assets/1cefdbad-4f77-4dd1-b93f-6584b04639af)

## Ruby and Rails Versions

- **Ruby**: 3.3.0
- **Rails**: 7.1.3.4

## Database

- **Database**: PostgreSQL
- **PostgreSQL Version**: 16.1

## Demo

To run the application locally:

1. Clone this repository.
2. Install dependencies using `bundle install`.
3. Set up the database with `rails db:create`, `rails db:migrate` and `rails db:seed`.
4. Start the Rails server using `bin/dev`.
5. Access the application at `http://localhost:3000`.

## Additional Notes

This project was developed as part of a technical assessment, focusing on functionality rather than deployment. The application includes:

- Secure user authentication and role-based access.
- Seamless interaction between tenants, owners, and admins for renting and managing apartments.
- A clear flow for ownership applications, property listings, booking requests, and dispute resolution.
- Easy role switching for owners between Tenant and Owner modes.
- Multilingual support for English and French.

Feel free to explore the application!
