FactoryGirl.define do 
  factory :user do 
    email 'sample@emal.com'
    name 'name'
    password 'somepass'
    password_confirmation 'somepass'
  end
end
