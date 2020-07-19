FactoryBot.define do
  factory :post do
    id {0}
    title {'オムライス'}
    text {'delicious'}
    url { 'https://example.com' }
    img { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/avocado-1838785_1920.jpg"))}
    # created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    user
  end
end
