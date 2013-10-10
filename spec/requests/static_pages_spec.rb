require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Simple Store'" do
      visit '/static_pages/home'
      expect(page).to have_content('Simple Store')
    end
  end  
end
