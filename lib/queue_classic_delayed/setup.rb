module QC
  module Delayed
    class Setup
      # Public: Creates a table for storing delayed jobs using the current
      # postgresql connection.
      #
      # Returns nothing.
      # Raises RuntimeError if something goes wrong.
      def self.create
        sql = """
          CREATE TABLE #{QC::Delayed::TABLE_NAME} (
              id serial PRIMARY KEY,
              q_name varchar(255),
              method varchar(255),
              args text,
              delayed_until timestamptz
          );

          CREATE INDEX idx_qcd_on_delayed_until ON queue_classic_delayed_jobs (delayed_until);
        """
        QC.default_conn_adapter.execute(sql)
      end

      # Public: Drops the table used for storing delayed jobs using the
      # current postgresql connection.
      #
      # Returns nothing.
      # Raises RuntimeError if something goes wrong.
      def self.drop
        QC.default_conn_adapter.execute("DROP TABLE IF EXISTS #{QC::Delayed::TABLE_NAME}")
      end
    end
  end
end
