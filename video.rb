#require titleize.rb

class Shop
  attr_accessor :library, :r_price, :c_price, :n_price, :o_price

  def initialize
    #@library = godfather: "R", junglebook: "C", themartian: "N", metropolis: "O"}
    @library = Array.new
    load_library
    print_library
    interface
  end

  def interface
    while true
      puts
      puts "Commands: invoice, list"
      puts "'CTRL C' to exit"
      input = gets.chomp

      case input
      when "invoice", "i"
        create_invoice
      when "list", "l"
        print_library
      else
        puts "Invalid Command!"
      end
    end
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
    #puts " %-20s %05d" % ['Movie', 12]
    puts "Movie\t\tType\tDays\tPrice"
    puts

    @customer.rentals.each do |rental|
      movie = rental[0]
      title = movie.title
      type = movie.type
      price = movie.price
      duration = rental[1]
      #puts "#{title}\t\t#{type}\t#{duration}\t#{price}"
      puts "#{title}".ljust(15) + "\t#{type}\t#{duration}\t#{price}"


      #@customer.to_pay += duration.to_f * price.to_f
      @cost_for_single_film
      @customer.frequent_renter_points += 1
    end

    puts
    puts "** Amount owed is #{@customer.to_pay}"
    puts "** You earned 4 frequent renter points"
  end

  def cost_for_single_film
    # regular price for all films is 1.5

    # new releases cost 3 for EVERY day
    if movie.type == "N"
      @customer.to_pay += duration.to_f * price.to_f
      # bonus frequent renter point for 2 day new rental release
      if duration.to_i > 1
        customer.frequent_renter_points += 1
      end
    end

    # childrens films cost 1.5 for first 3 days
    if movie.type == "C"
      if duration < 4
        @customer.to_pay += price.to_f
      else
        @customer.to_pay += price.to_f + (price.to_f * (duration.to_f - 3))
      end
    end

    # regular films cost 2 for the first 2 days
    if movie.type == "R"
      if duration < 3
        @customer.to_pay += price.to_f
      else
        @customer.to_pay += price.to_f + (price.to_f * (duration.to_f - 2))
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
    @library.each do |movie|
      puts
      puts "Title: " + movie.title
      puts "Type: " + movie.type
      puts "Price per day: " + movie.price.to_s
    end
  end

end



class Movie
  attr_accessor :title, :type, :price
  def initialize(title, type)
    @r_price = 2
    @c_price = 1.5
    @n_price = 3
    #@o_price = 1.5

    @title = title
    @type = type
    @price = get_price(@type)
  end

  def get_price(type)
    case type
    when "N"
      @n_price
    else
      @r_price
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
end

@shop = Shop.new
