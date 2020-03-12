# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

return if User.any?
user_ids = (0..9999).to_a
user_ids.each do |index|
  User.create!(
    name: "name #{index}",
    username: "name_#{index}" ,
    manager_id: index.zero? ? nil : (1..index).to_a.sample,
    role: index.zero? ? index : 1,
    password: '123123',
    password_confirmation: '123123'
  )
end
