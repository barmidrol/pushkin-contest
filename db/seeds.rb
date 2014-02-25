# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all

u = User.new
u.username = "Alex"
u.url = "http://yandex.by"
u.level = 3
u.save

u = User.new
u.username = "Ars"
u.url = "http://yandex.by"
u.level = 5
u.save

u = User.new
u.username = "Valik"
u.url = "http://yandex.by"
u.level = 5
u.save