module Ledger
  ##
  # Declaration for list of entries
  class Journal
    attr_reader :entries

    def initialize(params = {})
      @entries = params[:entries] || []
    end

    def to_s
      @entries.map(&:to_s).join("\n")
    end

    class << self
      def from_files(files)
        Journal.new(
          entries: files.map { |x| from_file(x).entries }.flatten
        )
      end

      def from_file(file)
        entries = read_file_chunks(file).map { |x| Entry.from_lines(x) }
        Journal.new(entries: entries)
      end

      private

      def read_file_chunks(file)
        chunks = File.read(file).split("\n").chunk_while { |_, x| x =~ /^\s/ }
        chunks.select { |x| x.size > 1 }
      end
    end
  end
end
