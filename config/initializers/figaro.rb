Figaro.require_keys("secret_key_base")

Rails.application.config.secret_key_base = Figaro.env.secret_key_base
Rails.application.config.github_key = Figaro.env.github_key 
Rails.application.config.github_secret = Figaro.env.github_secret 

