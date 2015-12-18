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
      add_to_rentals(title)
    end

    p @customer.rentals
    print_invoice
  end

  def add_to_rentals(title)
    #add movie obj & duration
    @exists = "false"
    @library.each do |movie|
      if movie.title == title
        @customer.rentals.push(movie)
        @exists = "true"
      end
    end
    if @exists == "false"
      puts "Title Not Found!"
    end
  end



  def print_invoice
    puts
    puts "Record for Stewart:"
    puts
    #puts " %-20s %05d" % ['Movie', 12]
    puts "Movie\t\tType\tDays\tPrice"
    puts

    @customer.rentals.each do |rental|
      title = rental[0]
      duration = rental[1]
      puts "#{title}\t\t#{duration}\t#{duration}\t#{duration}"
    end

    puts
    puts "** Amount owed is 777"
    puts "** You earned 4 frequent renter points"
  end

  def load_library
    @library.push Movie.new("the godfather", "R")
    @library.push Movie.new("jungle book", "C")
    @library.push Movie.new("the martian", "N")
    @library.push Movie.new("metropolis", "O")
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
    @o_price = 1.5

    @title = title
    @type = type
    @price = get_price(@type)
  end

  def get_price(type)
    case type
    when "R"
      @r_price
    when "C"
      @c_price
    when "N"
      @n_price
    when "O"
      @o_price
    end
  end
end

class Customer
  attr_accessor :name, :rentals

  def initialize(name)
    @name = name
    @rentals = []
  end
end

@shop = Shop.new
