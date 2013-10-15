require 'spec_helper'

describe "Product pages" do

  subject { page }

  describe "show page" do
    let(:product) { FactoryGirl.create(:product) }
    before { visit product_path(product) }
    
    it { should have_content(product.name) }
    it { should have_content(product.price) }
    it { should have_title(product.name) }
  end

    
  describe "new page" do
    before { visit new_product_path }

    it { should have_content('Add new product') }
    it { should have_title(full_title('Add new product')) }
  end  

  describe "product creation" do

    before { visit new_product_path }

    let(:submit) { "Create new product" }

    describe "with invalid information" do
      it "should not create a product" do
        expect { click_button submit }.not_to change(Product, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",  with: "Game Boy"
        fill_in "Price", with: "49.99"
      end

      it "should create a product" do
        expect { click_button submit }.to change(Product, :count).by(1)
      end
    end
  end
end
