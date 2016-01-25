FactoryGirl.define do 
  factory :movie do 
    sequence :title do |n|
      'Movie #{n}'
    end
    rating 1
    description ""
    url "http://example.com"
  end
end
