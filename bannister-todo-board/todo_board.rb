require_relative "./list.rb"

class TodoBoard

    def initialize(label)
        @lists = Hash.new()
    end

    def get_command
        print "\nEnter a command: "
        cmd, list, *args = gets.chomp.split(' ')

        case cmd
        when "mklist"
            @lists[list] = List.new(list)
        when "ls"
            puts @lists.keys
        when "showall"
            @lists.each { |title, list| list.print}
        when "mktodo"
            @lists[list].add_item(*args)
        when "up"
            @lists[list].up(*args.map(&:to_i))
        when "down"
            @lists[list].down(*args.map(&:to_i))
        when "swap"
            @lists[list].swap(args[0].to_i, args[1].to_i)
        when "sort"
            @lists[list].sort_by_date!
        when "priority"
            @lists[list].print_priority
        when "print"
            args.length > 0 ? @lists[list].print_full_item(args[0].to_i) : @lists[list].print
        when "toggle"
            @lists[list].toggle_item(args[0].to_i)
        when "rm"
            @lists[list].remove_item(args[0].to_i)
        when "purge"
            @lists[list].purge
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
