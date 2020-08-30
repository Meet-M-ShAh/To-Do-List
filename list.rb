require './item.rb'
class List

    LINE_WIDTH = 57
    INDEX_COL_WIDTH = 5
    ITEM_COL_WIDTH = 20
    DEADLINE_COL_WIDTH = 10
    STATUS_COL_WIDTH = 8

    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = nil)
        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, description)
            return true
        else
            return false
        end
    end

    def size
        return @items.size
    end

    def valid_index?(index)
        return false if index < 0 || index > self.size-1
        return true
    end

    def swap(ind1, ind2)
        if valid_index?(ind1) && valid_index?(ind2)
            @items[ind1], @items[ind2] = @items[ind2], @items[ind1]
            return true
        else
            return false
        end
    end

    def [](index)
        if valid_index?(index)
            return @items[index]
        else
            return nil
        end
    end

    def priority
        return @items[0]
    end

    def print
        puts "-" * LINE_WIDTH
        puts " " * 16 + self.label.upcase
        puts "-" * LINE_WIDTH
        puts "#{'SR. No.'.ljust(INDEX_COL_WIDTH)} | #{'Item'.ljust(ITEM_COL_WIDTH)} | #{'Deadline'.ljust(DEADLINE_COL_WIDTH)} | #{'Status'.ljust(STATUS_COL_WIDTH)}"
        puts "-" * LINE_WIDTH
        @items.each_with_index do |item, i|
            sta = "pending"
            if item.status == true
                sta = "completed"
            end
            puts "  #{(i+1).to_s.ljust(INDEX_COL_WIDTH)} | #{item.title.ljust(ITEM_COL_WIDTH)} | #{item.deadline.ljust(DEADLINE_COL_WIDTH)} | #{sta.ljust(STATUS_COL_WIDTH)}"
        end
        puts "-" * LINE_WIDTH
    end

    def print_full_item(index)
        sta = "pending"
        if @items[index].status == true
            sta = "completed"
        end
        if valid_index?(index)
            puts "-" * LINE_WIDTH
            puts "1" + (" " * INDEX_COL_WIDTH) + @items[index].title + (" " * INDEX_COL_WIDTH) + @items[index].deadline.to_s + (" " * INDEX_COL_WIDTH) + sta
            if @items[index].description != nil
                puts @items[index].description
            end
            puts "-" * LINE_WIDTH
        end
    end

    def print_priority
        puts @items[0].title
        puts @items[0].deadline
        if @items[0].description != nil
            puts @items[0].description
        end
        sta = "pending"
        if @items[index].status == true
            sta = "completed"
        end
        puts sta
    end

    def up(index, amount = 1)
        if valid_index?(index)
            amount.times do
                if index == 0
                    break
                else
                    @items[index], @items[index-1] = @items[index-1], @items[index]
                    index -= 1
                end
            end
            return true
        else
            return false
        end
    end

    def down(index, amount = 1)
        if valid_index?(index)
            amount.times do
                if index == self.size-1
                    break
                else
                    @items[index], @items[index+1] = @items[index+1], @items[index]
                    index += 1
                end
            end
            return true
        else
            return false
        end
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

    def toggle_item(index)
        @items[index].toggle
    end

    def remove_item(index)
        if !valid_index?(index)
            return false
        else
            @items.reject! { |ele| ele == @items[index] }
        end
    end

    def purge
        @items.reject! { |item| item.status == true }
    end
end