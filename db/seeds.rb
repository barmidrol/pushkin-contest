# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

class ConfirmRegistrationValidator < ActiveModel::Validator
  def validate(record)
    return
  end
end

User.delete_all

usernames = ['alex', 'ars', 'valik', 'mike', 'george', 'frank']

fields = [:username, :name, :surname, :skype, :github, :phone, :vk]

usernames.each do |username|
  u = User.new
  u.rating = rand(3) * 400
  u.url = "http://#{username}.herokuapp.com"
  fields.each { |field| u.send(field.to_s + '=', username) }
  u.save
end
