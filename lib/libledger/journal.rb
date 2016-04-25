module Ledger
  ##
  # Declaration for list of entries
  class Journal
    attr_reader :entries

    def initialize(params = {})
      @entries = params[:entries] || []
    end

    class << self
      def from_files(files)
        Journal.new(
          entries: files.map { |x| from_file(x).entries }.flatten
        )
      end

      def from_file(file)
        Journal.new(
          entries: read_file_chunks(file).map do |x|
            Entry.from_lines(x)
          end
        )
      end

      private

      def read_file_chunks(file)
        File.read(file).split("\n").chunk_while { |_, x| x =~ /^\s/ }
      end
    end
  end
end
