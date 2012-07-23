# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fss_test_session',
  :secret      => 'e4910adb585377b9920c1723022d89c76fe7b142ebb8e367edbe2df19a26faf240d2db9abc9f95be1cd90496d4ef2cc982b8e218b3a386b53e3168b626c4eb59'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
