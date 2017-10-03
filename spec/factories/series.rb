FactoryGirl.define do
  factory :serie do
    imdb { Faker::Internet.password(8) }
    my_rating { Faker::Number.decimal(1, 1) } #=> '8.3'
    last_episode { Faker::Movie.quote }
    poster_uri { Faker::Internet.url }
    serie_type { Faker::Number.between(0, 1) == 0 ? 'watching' : 'wishing' }
    user
  end
end
