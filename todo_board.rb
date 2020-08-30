require './list.rb'

class TodoBoard
    def initialize
        @lists = {}
    end

    def get_command
        print "\nEnter a command: "
        cmd, target,  *args = gets.chomp.split(' ')

        case cmd
        when 'mklist'
            @lists[target] = List.new(target)

        when 'ls'
            @lists.keys.each { |label| puts ' ' + label }

        when 'showall'
            @lists.each_value(&:print)

        when 'mktodo'
            @lists[target].add_item(*args)

        when 'up'
            args.map!(&:to_i)
            @lists[target].up(*args)

        when 'down'
            args.map!(&:to_i)
            @lists[target].down(*args)

        when 'swap'
            args.map!(&:to_i)
            @lists[target].swap(*args)

        when 'sort'
            @lists[target].sort_by_date!

        when 'priority'
            @lists[target].print_priority

        when 'print'
            args.map!(&:to_i)
            if args.count == 0
                @lists[target].print
            else
                @lists[target].print_full_item(*args)
            end

        when 'toggle'
            args.map!(&:to_i)
            @lists[target].toggle_item(*args)

        when 'rm'
            args.map!(&:to_i)
            @lists[target].remove_item(*args)

        when 'purge'
            @lists[target].purge

        when 'quit'
            return false

        else
            print "Invalid command entered! Please enter valid command."

        end

        return true
    end

    def run
        while true
            return if !get_command
        end
    end
end

board = TodoBoard.new
board.run