namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    100.times do |n|
      name =  Faker::Name.name
      price = n + 0.99
      Product.create!(name: name,
                      price: price)
    end
  end
end  
