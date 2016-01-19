#require 'interface.rb'
require_relative 'interface.rb'
require 'pry'



class Shop

  attr_accessor :library, :r_price_per_day, :c_price_per_day, :n_price_per_day, :o_price_per_day

  def initialize
    @library = Array.new

    #load_library
    # print_library
    #interface
  end

  def create_invoice
    puts
    puts "Creating Invoice...(enter '123' when you are finished!)"
    puts "Enter Customer Name: "
    name = gets.chomp
    @customer = Customer.new(name)
    puts "customer = " + @customer.name

    loop do
      print "Enter Movie Title: "
      title = gets.chomp.downcase
      break if title == "123"
      puts
      print "Number of Days: "
      duration = gets.chomp
      # @customer.rentals.push([title, duration])
      add_to_rentals(title, duration)
    end
    puts "customer.rentals = "
    p @customer.rentals
    print_invoice
  end

  def add_to_rentals(title, duration)
    #add movie obj & duration
    @exists = "false"
    @library.each do |movie|
      if movie.title == title
        @customer.rentals.push([movie, duration])
        @exists = "true"
      end
    end
    if @exists == "false"
      puts "Title Not Found!"
    end
  end

  def print_invoice
    puts
    puts "Record for #{@customer.name.capitalize}:"
    puts
    puts "Movie\t\tType\tDays\tprice_per_day"
    puts

    @customer.rentals.each do |rental|
      movie = rental[0]
      title = movie.title
      type = movie.type
      price_per_day = movie.price_per_day
      duration = rental[1]

      #puts "#{title}\t\t#{type}\t#{duration}\t#{price_per_day}"
      puts "#{title}".ljust(15) + "\t#{type}\t#{duration}\t#{price_per_day}"

      #@customer.to_pay += duration.to_f * price_per_day.to_f
      cost_for_single_film(type, duration, price_per_day)
      @customer.frequent_renter_points += 1
    end

    puts
    puts "** Amount owed is #{@customer.to_pay}"
    puts "** You earned #{@customer.frequent_renter_points} frequent renter points"
  end

  def cost_for_single_film(type, duration, price_per_day)
    # regular price_per_day for all films is 1.5

    # new releases cost 3 for EVERY day
    if type == "N"
      @customer.to_pay += duration.to_f * price_per_day.to_f
      # bonus frequent renter point for 2 day new rental release
      if duration.to_i > 1
        # @customer.frequent_renter_points += 1
        @customer.add_frequent_renter_point
      end
    end

    # childrens films cost 1.5 for first 3 days
    if type == "C"
      if duration.to_i < 4
        @customer.to_pay += price_per_day.to_f
      else
        @customer.to_pay += price_per_day.to_f + (price_per_day.to_f * (duration.to_f - 3))
      end
    end

    # regular films cost 2 for the first 2 days
    if type == "R"
      if duration.to_i < 3
        @customer.to_pay += price_per_day.to_f
      else
        @customer.to_pay += price_per_day.to_f + (price_per_day.to_f * (duration.to_f - 2))
      end
    end
  end

  def load_library
    @library.push Movie.new("godfather", "R")
    @library.push Movie.new("jungle book", "C")
    @library.push Movie.new("martian", "N")
    @library.push Movie.new("metropolis", "R")
    @library.push Movie.new("m", "R")
    @library.push Movie.new("a", "N")
    @library.push Movie.new("b", "N")
    @library.push Movie.new("c", "C")
    @library.push Movie.new("d", "C")
  end

  def print_library
    puts "Movie\t\tType\tprice_per_day Per Day"
    puts
    @library.each do |movie|
      puts "#{movie.title}".ljust(15) + "\t#{movie.type}\t#{movie.price_per_day.to_s}"
    end
  end
end

class Movie
  attr_accessor :title, :type, :price_per_day
  def initialize(title, type)
    @r_price_per_day = 2
    @c_price_per_day = 1.5
    @n_price_per_day = 3
    #@o_price_per_day = 1.5

    @title = title
    @type = type
    @price_per_day = get_price_per_day(@type)
  end

  def get_price_per_day(type)
    case type
    when "N"
      @n_price_per_day
    else
      @r_price_per_day
    end
  end
end

class Customer
  attr_accessor :name, :rentals, :to_pay, :frequent_renter_points

  def initialize(name)
    @name = name
    @rentals = []
    @to_pay = 0
    @frequent_renter_points = 0
  end

  def add_frequent_renter_point
    @frequent_renter_points += 1
  end
end

@shop = Shop.new
@shop.load_library
@shop.print_library
#binding.pry
@interface = Interface.new(@shop)
@interface.start_interface
