module QC
  module Delayed
    class Scheduler
      def self.perform
        sql = """
          SELECT *
            FROM #{QC::Delayed::TABLE_NAME}
            WHERE current_timestamp > delayed_until
        """
        jobs_to_queue = QC::Conn.execute(sql)

        return unless jobs_to_queue
        jobs_to_queue = [jobs_to_queue] if jobs_to_queue.is_a? Hash

        jobs_to_queue.each do |job|
          method = job['method']
          args = QC::OkJson.decode(job['args'])
          QC.enqueue(method, *args)
        end
      end
    end
  end
end
