require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "product saves ok" do
      @product = Product.new
      @cat = Category.new
      @cat.name = 'Category'
      @product.name = 'Home plant' 
      @product.price_cents = 30000
      @product.quantity = 5
      @product.category = @cat
      expect(@product.valid?).to be true
    end

    it "name exists" do
      @product = Product.new
      @product.name = nil
      @product.valid?

      expect(@product.errors[:name]).to  include("can't be blank")
      @product.name = 'Home plant'  
      @product.valid? 
      expect(@product.errors[:name]).not_to  include("can't be blank")
    end

    it "price exists" do
      @product = Product.new
      @product.price_cents = nil 
      @product.valid?
      expect(@product.errors[:price_cents]).to  include("is not a number")

      @product.price_cents = 30000  
      @product.valid? 
      expect(@product.errors[:price_cents]).not_to  include("is not a number")
    end

    it "quantity exists" do
      @product = Product.new
      @product.quantity = nil  
      @product.valid?
      expect(@product.errors[:quantity]).to  include("can't be blank")

      @product.quantity = 5
      @product.valid? 
      expect(@product.errors[:quantity]).not_to  include("can't be blank")
    end

    it "category exists" do
      @cat = Category.new
      @product = Product.new

      @product.category = nil 
      @product.valid?
      expect(@product.errors[:category]).to  include("can't be blank")

      @product.category = @cat 
      @product.valid? 
      expect(@product.errors[:category]).not_to  include("can't be blank")
    end
  end
end
