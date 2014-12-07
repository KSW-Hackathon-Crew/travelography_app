# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.destroy_all
Plan.destroy_all
Activity.destroy_all
Photo.destroy_all

user1 = User.create(email: "theerickramer@gmail.com", password: "pass")
user2 = User.create(email: "mariatschettino@gmail.com", password: "pass")
user3 = User.create(email: "freejacque@gmail.com", password: "pass")

