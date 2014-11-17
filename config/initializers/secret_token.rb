# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Cupid::Application.config.secret_key_base = ENV["SECRET_KEY"] || '1511590386bf226b4836c4e67ffe14ca33b28f7a6089573126a8c3d278725f52a9d08657f1ae8298019bed3be922e9ed7a2b96f406422910242ba54a79c7fd12'
