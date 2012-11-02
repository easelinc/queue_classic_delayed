require 'bundler/setup'
require 'queue_classic'
require 'queue_classic_delayed'

ENV["DATABASE_URL"] ||= "postgres:///queue_classic_delayed_test"

RSpec.configure do |config|
  config.before do
    QC::Conn.execute("SET client_min_messages TO 'warning'")
    QC::Delayed::Setup.drop
    QC::Delayed::Setup.create
    QC::Conn.disconnect
  end
end
