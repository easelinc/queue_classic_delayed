require 'spec_helper'

describe 'QC::Delayed' do
  it 'should have a version' do
    QC::Delayed::VERSION.should_not be_nil
  end

  describe 'enqueuing' do
    before do
      @delayed_until = DateTime.now + 1
      QC::Delayed.enqueue(@delayed_until, 'Kernel.puts', 'Hello Tomorrow!')
    end

    subject { QC::Conn.execute("SELECT delayed_until, method, args from #{QC::Delayed::TABLE_NAME}") }

    it 'saves the proper timestamp for delaying' do
      DateTime.parse(subject['delayed_until']).should be_within(0.9).of(@delayed_until)
    end

    it 'saves the proper method' do
      subject['method'].should eq('Kernel.puts')
    end

    it 'saves the proper arguments' do
      JSON.parse(subject['args']).should eq(['Hello Tomorrow!'])
    end
  end
end
