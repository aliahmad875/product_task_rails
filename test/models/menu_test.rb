require_relative "../test_helper"

class MenuTest < ActiveSupport::TestCase
    setup do
        @all_products = Product.all
        @cart = {}
        @all_products.each do |p|
            @cart.merge!(p.product_code => 0)
        end
        @menu = Menu.new
    end
    
    test "Testing one coffie added in cart" do
        @cart["CF1"] += 1
        menu_cart = @menu.product_add_and_remove_to_cart(@all_products.last, @cart, 1)
        assert_equal menu_cart, @cart 
    end

    test "Testing one Strawberries remove in cart" do
        @cart["SR1"] += 1
        menu_cart = @menu.product_add_and_remove_to_cart(@all_products.second, @cart, 2)
        assert_equal menu_cart, @cart 
    end
    
    test "Buy one get one free discount" do
        @cart["GR1"] += 1
        total_bill = @menu.calculate_price(@all_products, @cart)
        assert_equal total_bill, @all_products.first.price 
    end

    test "Buy more then 3 Strawberries discount" do
        @cart["SR1"] += 3
        @cart["CF1"] += 1
        total_bill = @menu.calculate_price(@all_products, @cart)
        assert_equal total_bill, 24.73
    end

    test "Buy more then 3 Coffe discount" do
        @cart["GR1"] += 1
        @cart["SR1"] += 2
        @cart["CF1"] += 3
        total_bill = @menu.calculate_price(@all_products, @cart)
        assert_equal total_bill, 35.57
    end

    test "Buy product invalid price calculate" do
        @cart["GR1"] += 1
        @cart["CF1"] += 3
        total_bill = @menu.calculate_price(@all_products, @cart)
        assert_not_equal total_bill, 105.57
    end

    test "print bill" do
        @cart["GR1"] += 1
        @cart["CF1"] += 3
        total_bill = @menu.calculate_price(@all_products, @cart)
        assert_not_equal total_bill, 105.57
    end
end