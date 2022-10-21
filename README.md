# README

# Assumptions:
 1. We assume that there is only one discount that is applied on a complete order. Like if a user buys 3 or more strawberries with 3 or more coffees then we apply the discount that benefits our customer like in strawberry user save 5€ and in coffee the user saves 7€ then we apply 7€ discount instead of 5€ because it benefits more.

Please Follow these Steps

# Run this command Install bundler and bundle

1-  => gem install bundler
	
	=> bundle install 

# Run this command Create DataBase, Migrate and Seed (Add Product data in database)

2- `rails db:create && rails db:migrate && rails db:seed` 

# Run this command Test Database Load
 
3- `rails db:test:prepare --trace && rails db:seed RAILS_ENV=test`

# Run this Command then start CLI Application

4- `rake run:run_application`

# Run this command then run all test cases

5- `rails test` 