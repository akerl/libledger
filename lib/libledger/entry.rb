require 'date'

module Ledger
  ENTRY_SUBJECT_LINE_REGEX = %r{^(\d+/\d+/\d+) (?:([*!]) )?(.*)$}
  ENTRY_ACTION_LINE_REGEX = /^\s+(\w+[^(  )\t]*)(?:\s+(.*))?$/

  ##
  # Declaration for entry object
  class Entry
    def initialize(params = {})
      @data = params
    end

    def name
      @name ||= @data[:name]
    end

    def state
      return @state if @state
      @state = case @data[:state]
               when '*'
                 :cleared
               when '!'
                 :pending
               else
                 raise "Unexpected state on #{name}: #{@data[:state]}"
               end
    end

    def date
      @date ||= Date.parse(@data[:date])
    end

    def actions
      @actions ||= @data[:actions]
    end

    class << self
      def from_lines(lines)
        params = parse_first_line(lines.shift)
        params[:actions] = lines.map { |x| parse_action_line x }
        Entry.new(params)
      end

      private

      def parse_first_line(line)
        date, state, name = line.match(ENTRY_SUBJECT_LINE_REGEX).captures
        {
          date: date,
          state: state,
          name: name
        }
      end

      def parse_action_line(line)
        name, amount = line.match(ENTRY_ACTION_LINE_REGEX).captures
        {
          name: name,
          amount: amount
        }
      end
    end
  end
end
