require 'spec_helper'

describe 'QC::Delayed' do
  it 'should have a version' do
    QC::Delayed::VERSION.should_not be_nil
  end
end
