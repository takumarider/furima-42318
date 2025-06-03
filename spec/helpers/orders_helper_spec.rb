require 'database_cleaner' # DatabaseCleaner を読み込む

RSpec.configure do |config|
  # ... 既存の設定 ...

  # FactoryBot の設定 (もしなければ追記)
  config.include FactoryBot::Syntax::Methods

  # DatabaseCleaner の設定 (もしなければ追記)
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # DEPRECATION WARNING の対応（任意だが推奨）
  # config.fixture_path = "#{::Rails.root}/spec/fixtures" # この行があればコメントアウトまたは削除
  config.fixture_paths = [Rails.root.join('spec/fixtures')] # この行を追加/修正
  # ... その他の設定 ...
end
