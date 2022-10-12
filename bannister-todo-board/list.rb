require_relative "./item.rb"

class List
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description="")

        new_item = Item.new(title, deadline, description)
        @items.push(new_item)
        return true
        # begin

        # rescue
        #     return false
        # end
    end

    def [] (index)
        if valid_index?(index)
            return @items[index]
        else
            return nil
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        index >= 0 && index < @items.length
    end

    def swap(index_1, index_2)
        if !(valid_index?(index_1) && valid_index?(index_2))
            return false
        else
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            return true
        end
    end

    def priority
        @items[0]
    end

    def print
        puts "-------------------------------------------------------------------"
        puts " ".ljust(20) + @label.ljust(20)
        puts "-------------------------------------------------------------------"
        puts "Index".ljust(10) + "| " + "Item".ljust(15) + "| " + "Deadline".ljust(15) + "| done?"
        puts "-------------------------------------------------------------------"
        @items.each_with_index do |item, idx|
            puts idx.to_s.ljust(10) + "| " + item.title.to_s.ljust(15) + "| " + item.deadline.to_s.ljust(15) + "| " + item.done.to_s
        end
        return nil
    end

    def print_full_item(index)
        item = @items[index]
        puts "------------------------------------------------------------------"
        puts item.title.to_s.ljust(40) + item.deadline.to_s.ljust(12) + item.done.to_s
        puts item.description.ljust(40)
        puts "------------------------------------------------------------------"
        return nil
    end

    def print_priority
        print_full_item(0)
    end

    def up(idx, amt=1)
        if !valid_index?(idx)
            return false
        else
            while amt > 0
                swap(idx, idx - 1)
                idx -= 1
                amt -= 1
            end
            return true
        end
    end

    def down(idx, amt = 1)
        if !valid_index?(idx)
            return false
        else
            while amt > 0
                swap(idx, idx + 1)
                idx += 1
                amt -= 1
            end
            return true
        end
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

    def toggle_item(idx)
        @items[idx].toggle
    end

    def remove_item(idx)
        if !valid_index?(idx)
            return false
        else
            @items.delete_at(idx)
            return true
        end
    end

    def purge
        @items.select! { |item| item.done != true}
    end
end
