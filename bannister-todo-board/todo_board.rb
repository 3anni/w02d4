require_relative "./list.rb"

class TodoBoard

    def initialize(label)
        @list = List.new(label)
    end

    def get_command
        print "\nEnter a command: "
        cmd, *args = gets.chomp.split(' ')

        case cmd
        when "mktodo"
            args.length > 2 ? @list.add_item(*args) : @list.add_item(*args)
        when "up"
            args.length > 1 ? @list.up(*args.map(&:to_i)) : @list.up(*args.map(&:to_i))
        when "down"
            args.length > 1 ? @list.down(*args.map(&:to_i)) : @list.down(*args.map(&:to_i))
        when "swap"
            @list.swap(args[0].to_i, args[1].to_i)
        when "sort"
            @list.sort_by_date!
        when "priority"
            @list.print_priority
        when "print"
            args.length > 0 ? @list.print_full_item(args[0].to_i) : @list.print
        when "toggle"
            @list.toggle_item(args[0].to_i)
        when "rm"
            @list.remove_item(args[0].to_i)
        when "purge"
            @list.purge
        when "quit"
            return false
        else
            print "Sorry, that command is not recognized."
        end
        true
    end

    def run
        while get_command
        end
    end
end
