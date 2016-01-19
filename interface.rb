class Interface

  def initialize(shop)
    @shop = shop
  end

  def start_interface
    while true
      puts
      puts "Commands: invoice, list"
      puts "'CTRL C' to exit"
      input = gets.chomp

      case input
      when "invoice", "i"
        #binding.pry
        @shop.create_invoice

      when "list", "l"
        @shop.print_library
      else
        puts "Invalid Command!"
      end
    end
  end
end
