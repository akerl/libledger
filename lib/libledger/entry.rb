require 'date'

module Ledger
  ENTRY_SUBJECT_LINE_REGEX = %r{^(\d+/\d+/\d+) (?:([*!]) )?(.*)$}.freeze
  ENTRY_ACTION_LINE_REGEX = /^\s+(\w+[^( )\t]*)(?:\s+(.*))?$/.freeze
  ENTRY_TAG_LINE_REGEX = /^\s+; (\w+): (.*)$/.freeze

  STATE_MAPPING = {
    cleared: '*',
    pending: '!'
  }.freeze

  ##
  # Declaration for entry object
  class Entry
    include Comparable

    def initialize(params = {})
      @data = params
    end

    def name
      @name ||= @data[:name]
    end

    def state
      @state ||= @data[:state]
    end

    def state_sym
      @state_sym ||= state.is_a?(Symbol) ? state : STATE_MAPPING.invert[state]
    end

    def state_str
      @state_str ||= state.is_a?(Symbol) ? STATE_MAPPING[state] : state
    end

    def date
      return @date if @date
      @date ||= @data[:date] if @data[:date].is_a? Date
      @date ||= Date.parse(@data[:date])
    end

    def actions
      @actions ||= @data[:actions]
    end

    def tags
      @tags ||= @data[:tags] || {}
    end

    def to_s
      "#{subject_line}#{tag_lines}#{action_lines.join("\n")}\n"
    end

    def <=>(other)
      return nil unless other.is_a? Ledger::Entry
      date <=> other.date
    end

    private

    def subject_line
      "#{date.strftime('%Y/%m/%d')} #{state_str} #{name}\n"
    end

    def tag_lines
      res = tags.map { |k, v| "    ; #{k}: #{v}" }.join("\n")
      res += "\n" unless res.empty?
      res
    end

    def action_lines
      actions.map do |x|
        line = "    #{x[:name]}"
        line += (' ' * action_padding(x)) + x[:amount] if x[:amount]
        line
      end
    end

    def action_padding(action, width = 62)
      # Minus 4 for intent at front of line
      width - 4 - action[:name].size - action[:amount].size
    end

    class << self
      def from_lines(lines)
        params = parse_first_line(lines.shift)
        params[:tags] = {}
        params[:actions] = lines.map do |x|
          m = x.match(ENTRY_TAG_LINE_REGEX)
          next(parse_action_line(x)) unless m
          params[:tags][m[1]] = m[2]
          nil
        end.compact
        Entry.new(params)
      end

      private

      def parse_tag_line(line)
        line.match(ENTRY_TAG_LINE_REGEX).captures
      end

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
