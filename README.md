Questions and Answers Thinknetica RoR advanced course application.

This app based on main idea of Stackoverflow: people can ask questions and create answers for them, created for lerning how some gems and technologies works.

Ruby & Rails version
* ruby 2.7.2
* rails 6.1.7

Authentication:
* gem 'devise'
* gem 'omniauth'
* gem 'omniauth-github'
* gem 'omniauth-vkontakte'

Authorization with Policies
* gem cancancan

App has REST API
* gem 'active_model_serializers'
* gem 'doorkeeper'

Attach files to questions/answers with saving on cloud storage
* gem 'aws-sdk-s3'

Background jobs (like email)
* active job
* gem 'sidekiq'
* gem 'whenever'

Redis for sidekiq and caching
* gem 'redis-rails'

Sphinx search (fulltext search)
* gem 'thinking-sphinx'

Test Driven Development (application is fully covered by tests: 496 specs)
* gem 'rspec-rails'
* gem 'factory_bot_rails'
* gem 'shoulda-matchers'

Feature (acceptance) testing with JS
* gem 'capybara'

Views written on Slim & Bootstrap
* gem 'slim-rails'
* gem 'bootstrap'

Nested forms
* gem 'cocoon'

PostgreSQL as main db
* gem 'pg'

Ready to deploy
* gem 'capistrano'

Different production webserver
* gem 'unicorn'
* gem 'passenger'

Services (job queues, cache servers, search engines, etc.)
* Postgres
* Redis
* Sidekiq
* Sphinx
