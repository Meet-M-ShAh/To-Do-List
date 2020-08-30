class Item
    attr_accessor :title, :description
    attr_reader :deadline, :status

    def self.valid_date?(date_string)
        y, m, d = date_string.split("-")
        y = y.to_i
        m = m.to_i
        d = d.to_i
        m > 0 && m < 13 && d > 0 && d < 32
    end

    def initialize(title, deadline, description)
        @title = title
        @deadline = deadline
        @description = description
        @status = false
        raise "Invalid Date or Date Format in DeadLine" if !Item.valid_date?(deadline)
    end

    def deadline=(new_deadline)
        raise "Invalid Date or Date Format in DeadLine" if !Item.valid_date?(new_deadline)
        @deadline = new_deadline
    end

    def toggle
        if @status == false
            @status = true
        else
            @status = false
        end
    end
end