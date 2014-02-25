require 'queue_classic_delayed/version'
require 'queue_classic_delayed/setup'
require 'queue_classic_delayed/scheduler'

module QC
  module Delayed
    TABLE_NAME = "queue_classic_delayed_jobs"

    # Public: Queue this method with the given arguments to run after
    # the given time.
    #
    # delayed_until  - The time after which this job should be run.
    # method         - The name of the method to execute.
    # args           - The array of arguments to execute the method with.
    #
    # Returns nothing.
    # Throws RuntimeError if the job can not be queued.
    def self.enqueue(delayed_until, method, *args)
      sql = "INSERT INTO #{TABLE_NAME} (q_name, delayed_until, method, args) VALUES ($1, $2, $3, $4)"
      QC::Conn.execute(sql, nil, delayed_until, method, JSON.dump(args))
    end

    # Test-only: This function is used by tests to determine if a job is
    # removed properly.
    #
    # Returns the number of jobs that are currently delayed.
    def self.count
      sql = "SELECT COUNT(*) FROM #{TABLE_NAME}"
      QC::Conn.execute(sql)["count"].to_i
    end
  end
end
