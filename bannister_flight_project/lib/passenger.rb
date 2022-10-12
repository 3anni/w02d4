class Passenger
    attr_reader :name

    def initialize(name)
        @name = name
        @flight_numbers = []
    end

    def upcase(string)
        string.split("").map(&:upcase).join("")
    end

    def has_flight?(flight_num)
        @flight_numbers.include?(upcase(flight_num))
    end

    def add_flight(flight_num)
        @flight_numbers.push(upcase(flight_num)) if !has_flight?(upcase(flight_num))
    end
end
