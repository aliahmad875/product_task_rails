class Menu
    
    #Start Application
    def run
        all_products = Product.all
        cart = {}
        all_products.each do |p|
            cart.merge!(p.product_code => 0)
        end
        choices(all_products, cart)
    end
    
    def choices(all_products, cart)

        while true 
            case home
            when '1'
                view_products(all_products)
            when '2'
                show_cart_product(all_products, cart)
            when '3'
                view_cart(cart)
            when '4'
                checkout(all_products, cart)
            when 'e'
                exit(0)
            else
                puts "invalid"
            end
        end
        
    end
    
    def home
        puts "Choice any one"
        puts "1. View products"
        puts "2. Add cart"
        puts "3. View cart"
        puts "4. Check out"
        puts "e. Exit"
        
        STDIN.gets.chomp

    end

    # view all products 
    def view_products(all_products)

        puts "| Product code | Name | Price |"

        all_products.each do |pr|
            puts "| #{pr.product_code} | #{pr.name} | #{pr.price}€ |" 
        end
        
    end
    
    def cart(p_choice, all_products, cart)

        product = all_products.find_by_id(p_choice)
        if product.present? && product.product_code.present?
            added_removed(product, cart)
       
        elsif p_choice == "h"
            home
        
        elsif p_choice == "e"
            exit(0)
        
        else
            puts "invalid"
            show_cart_product(all_products, cart)
        end
        
    end
    
    #Show All products in cart
    def show_cart_product(all_products, cart)
        
        all_products.each_with_index do |pr|
            puts "#{pr.id}. #{pr.name}"
        end
        
        puts "e. Exit" 

        p_choice = STDIN.gets.chomp
        cart(p_choice, all_products, cart)
    end

    #product add and removed in cart
    def added_removed(product, cart)
        name = product.name
        puts "1- Add #{name}"
        puts "2- Remove #{name}"
        ch = STDIN.gets.chomp
        product_add_and_remove_to_cart(product, cart, ch)

    end

    #Add Product in cart
    def product_add_and_remove_to_cart(product, cart, ch)
        
        code = product.product_code
        if ch.to_i == 1
            cart[code] += 1
        elsif ch.to_i == 2
            if cart[code] > 0
                cart[code] -= 1
            else
                cart[code] = 0
            end
        else
            puts "invalid"
            added_removed(product, cart)
        end  
        cart
    end 

    # Show Cart Details
    def view_cart(cart)

        puts "|Product code|\t|Quantity|"

        cart.each do |key, index|
            puts  "#{key}  \t\t  #{index}"
        end

    end
      
    #calculate prices
    def calculate_price(all_products, cart)

        total_price = 0
        if(cart["GR1"]>0 &&  cart["SR1"] == 0 && cart["CF1"] == 0)
            # Tea Buy one get one free 
            total_price += all_products.find_by_product_code("GR1").price * cart["GR1"]
        else
            total_price += all_products.find_by_product_code("GR1").price * cart["GR1"]

            if cart["SR1"] >= 3 && cart["CF1"] < 3
                # More then 3 Strawberries descount offer
                total_price += cart["SR1"] * 4.5
            else
                total_price += all_products.find_by_product_code("SR1").price * cart["SR1"]
            end

            if cart["CF1"] >= 3
                # More then 3 Coffe descount offer
                total_price += (all_products.find_by_product_code("CF1").price * 2/3) * cart["CF1"]
            else
                total_price += all_products.find_by_product_code("CF1").price * cart["CF1"]
            end
        end
        total_price

    end

    def repeat(word, repeats, cart, prod)
        if(cart["GR1"]>0 &&  cart["SR1"] == 0 && cart["CF1"] == 0)
            repeats = repeats * 2
            prod.push([word] * repeats)
        else
            prod.push([word] * repeats)
        end
    end

    # Total bill with products
    def print_bill(cart, total_price)
        
        prod=[]
        

        cart.each do |key, value|
            repeat(key, value, cart, prod)
        end
        
        prod = prod.flatten
        puts "| Product code |\t|Price|"
        
        if prod.present?
            puts  "| #{prod.join(', ')}  |  #{total_price}€ |" 
        end
        exit(0)
    end

    def checkout(all_products, cart)
        total_price = calculate_price(all_products, cart)
        print_bill(cart, total_price)      
    end
end