pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "price_calculator", to: "price_calculator.js"
pin "card", to: "card.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.1.0/lib/assets/compiled/rails-ujs.js"