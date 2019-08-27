module Ledger
  ##
  # Declaration for list of entries
  class Journal
    attr_reader :entries

    def initialize(params = {})
      @entries = params[:entries] || []
    end

    def to_s
      @entries.sort.map(&:to_s).join("\n")
    end

    class << self
      def from_files(files)
        Journal.new(
          entries: files.map { |x| from_file(x).entries }.flatten
        )
      end

      def from_file(file)
        from_text(File.read(file))
      end

      def from_text(text)
        Journal.new(entries: text_to_entries(text))
      end

      private

      def text_to_entries(text)
        text.split(/\n\n+/).map do |x|
          x.strip!
          next if x.start_with? ';'

          Entry.from_lines(x.split("\n"))
        end.compact
      end
    end
  end
end
