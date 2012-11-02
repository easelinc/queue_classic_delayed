require 'spec_helper'

describe 'QC::Delayed::Setup' do
  describe '#create' do
    it 'will create a database' do
      QC::Conn.should_receive(:execute).with("BEGIN")
      QC::Conn.should_receive(:execute).with(/CREATE TABLE/)
      QC::Conn.should_receive(:execute).with("COMMIT")
      QC::Delayed::Setup.create
    end
  end

  describe '#drop' do
    it 'will drop a database' do
      QC::Conn.should_receive(:execute).with("BEGIN")
      QC::Conn.should_receive(:execute).with(/DROP TABLE/)
      QC::Conn.should_receive(:execute).with("COMMIT")
      QC::Delayed::Setup.drop
    end
  end
end
