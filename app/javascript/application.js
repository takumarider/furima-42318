// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./price_calculator"
import "card"

import Rails from "@rails/ujs"
Rails.start()  // ← rails-ujs を有効にする！