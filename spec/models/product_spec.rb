require 'spec_helper'

describe Product do

  before { @product = Product.new(name: "Lego set", price: "22.99") }
  
  subject { @product }

  it { should respond_to(:name) }
  it { should respond_to(:price) }
  it { should respond_to(:released_at) }

  it { should be_valid }

  describe "when name is not present" do
    before { @product.name = " " }
    it { should_not be_valid }
  end  

  describe "when price is not present" do
    before { @product.price = " " }
    it { should_not be_valid }
  end  

  describe "when name is too long" do
    before { @product.name = "a" * 101 }
    it { should_not be_valid }
  end  

  describe "when name is already taken" do
    before do
      product_with_same_name = @product.dup
      product_with_same_name.name = @product.name.upcase
      product_with_same_name.save
    end

    it { should_not be_valid }
  end  
end
