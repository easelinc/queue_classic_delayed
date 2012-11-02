require 'spec_helper'

describe 'QC::Delayed::Scheduler' do
  context 'with no jobs to run' do
    before do
      tomorrow = DateTime.now + 1
      QC::Delayed.enqueue(tomorrow, 'Kernel.puts')
    end

    it 'schedules none of them' do
      QC.should_not_receive(:enqueue)
      QC::Delayed::Scheduler.perform
    end
  end

  context 'with a single job to run' do
    before do
      yesterday = DateTime.now - 1
      QC::Delayed.enqueue(yesterday, 'Kernel.puts')
    end

    it 'schedules it' do
      QC.should_receive(:enqueue).once
      QC::Delayed::Scheduler.perform
    end
  end

  context 'with multiple jobs to run' do
    before do
      yesterday = DateTime.now - 1
      QC::Delayed.enqueue(yesterday, 'Kernel.puts')
      QC::Delayed.enqueue(yesterday, 'Kernel.puts', 'Hello tomorrow!')
    end

    it 'schedules them' do
      QC.should_receive(:enqueue).exactly(2).times
      QC::Delayed::Scheduler.perform
    end
  end
end
