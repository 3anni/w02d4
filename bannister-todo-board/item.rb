require "date"

class Item
    attr_reader :deadline
    attr_accessor :title, :description

    def valid_date?(string)
        Date.parse(string).to_s == string rescue false
    end

    def initialize(title, deadline, description)
        @title = title
        if valid_date?(deadline)
            @deadline = deadline
        else
            throw new RuntimeError "deadline is not valid"
        end
        @description = description
    end

    def deadline=(new_deadline)
        if !valid_date?(new_deadline)
            throw RuntimeError.new "deadline is not valid"
        else
            @deadline = new_deadline
        end
    end
end
