# queue_classic_delayed

A simple gem which allows you to schedule queue_classic jobs in the
future.

It's important to note that queue_classic_delayed doesn't guarantee
exactly when a job will run. It will only place the specified job in the
job queue after the point in time that is specified.

## Setup

1. Install queue_classic (you already have queue_classic, setup right?)
1. Add queue_classic_delayed to your gemfile.
1. Run the migration below.
1. Setup `QC::Delayed::Scheduler.perfom` to execute at an interval you
   wish to check for new jobs.

## db/migrate/add_queue_classic_delayed.rb

```
require 'queue_classic_delayed'

class AddQueueClassicDelayed < ActiveRecord::Migration

  def self.up
    QC::Delayed::Setup.create
  end

  def self.down
    QC::Delayed::Setup.drop
  end
end
```

# Usage

```
# Will print 'hello from yesterday' 1 day from now
QC::Delayed.enqueue(1.day, 'Kernel.puts', 'hello from yesterday')
```

# Testing

1. Create a test database like so `createdb queue_classic_delayed_test`

# Future Work

1. Implement `QC::Delayed::Queue.enqueue` so we can handle items on a
   specific queue.
