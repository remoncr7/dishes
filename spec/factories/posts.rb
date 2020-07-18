FactoryBot.define do
  factory :post do

    title {'オムライス'}
    text {'delocious'}
    url { 'https://example.com' }
    img { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/avocado-1838785_1920.jpg"))}
    user
  end
end
