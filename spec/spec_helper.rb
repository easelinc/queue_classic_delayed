require 'bundler/setup'
require 'queue_classic'
require 'queue_classic_delayed'

ENV["DATABASE_URL"] ||= "postgres:///queue_classic_delayed_test"
