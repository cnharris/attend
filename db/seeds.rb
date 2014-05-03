# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Subscription.create([
    { :title => "$250 per month", :amount => 25000 }, 
    { :title => "$399 per month", :amount => 39900 },
    { :title => "$599 per month", :amount => 59900 }
  ])