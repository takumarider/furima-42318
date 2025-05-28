FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    category_id { 2 }
    status_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    shipping_day_id { 2 }
    price { 300 }
    association :user
    # image はfixture_file_uploadを使うのでここには書かないことが多いです
    # # ただし、ActiveStorageを使う場合は、after(:build)で画像を添付することができます。
    # image { fixture_file_upload('public/images/test_image.png') }
    # ここでは、ActiveStorageを使って画像を添付する方法を示します。
    # ただし、実際のテストでは、画像ファイルを用意しておく必要があります。
    # ここでは、public/images/test_image.pngというパスに画像ファイルがあることを前提としています。
    # 画像ファイルがない場合は、適切なパスに画像を配置してください。
    # ActiveStorageを使う場合、以下のようにafter(:build)で画像を添付します。
    # ただし、画像ファイルが存在することを確認してください。
    # 画像ファイルがない場合は、適切なパスに画像を配置してください。
     after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
