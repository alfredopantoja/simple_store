FactoryGirl.define do
  factory :product do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:price) { |n| n + 0.99  }
  end
end  
