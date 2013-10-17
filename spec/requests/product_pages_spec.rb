require 'spec_helper'

describe "Product pages" do

  subject { page }

  describe "index" do
    before { visit products_path } 
      
    it { should have_title('All products') }
    it { should have_content('All products') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:product) } }
      after(:all)  { Product.delete_all }

      it { should have_selector('div.pagination') }
      
      it "should list each product" do
        Product.paginate(page: 1).each do |product|
          expect(page).to have_selector('li', text: product.name)
        end
      end
    end

    describe "delete links" do

      it { should have_link('delete', href: product_path(Product.first)) }
      it "should be able to delete a product" do
        expect do
          click_link('delete', match: :first)
        end.to change(Product, :count).by(-1)
      end
    end    
  end  

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

describe "edit" do
  let(:product) { FactoryGirl.create(:product) }
  before { visit edit_product_path(product) }

  describe "page" do
    it { should have_content("Update product") }
    it { should have_title("Edit product") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Product Name" }
      let(:new_price) { 99.99 }
      before do
        fill_in "Name",  with: new_name
        fill_in "Price", with: new_price
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(product.reload.name).to eq new_name }
      specify { expect(product.reload.price).to eq new_price }
    end  
  end  
end
