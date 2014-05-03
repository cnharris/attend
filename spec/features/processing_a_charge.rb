require 'spec_helper'

feature 'Charge Form' do
  it 'should post a successful charge', :js => true do
    subject { page }
    visit(root_path)
    wait_for_ajax
    
    # check for form
    expect(page.has_css?("form#user-form")).to eq(true)
    
    # check the URI
    uri = URI.parse(current_url)
    expect(uri.path).to eq("/")
    expect(uri.fragment).to eq("/charges/new")
    
    # fill-in form
    page.find_by_id('subscription_id').find("option[value='2']").click()
    fill_in('user_name', :with => 'Christopher Harris')
    fill_in('company', :with => 'Groupon')
    fill_in('email', :with => 'cnharris@gmail.com')
    fill_in('phone', :with => '650-678-1417')
    fill_in('number', :with => '4242424242424242')
    page.find_by_id('month').find("option[value='03']").click()
    page.find_by_id('year').find("option[value='2015']").click()
    fill_in('cvv', :with => '123')
    
    # submit form
    page.find(".btn-submit").click()
    expect(page.find("form .user-form-errors", :visible => false)).to_not be_visible
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("")
    
    wait_for_ajax
    
    # check response
    expect(page).to have_text("Charge received!")
  end
  
  it 'should error on invalid inputs (email, phone)', :js => true do
    subject { page }
    visit(root_path)
    wait_for_ajax
    
    # check for form
    expect(page.has_css?("form#user-form")).to eq(true)
    
    # check the URI
    uri = URI.parse(current_url)
    expect(uri.path).to eq("/")
    expect(uri.fragment).to eq("/charges/new")
    
    # fill-in form
    page.find_by_id('subscription_id').find("option[value='2']").click()
    fill_in('user_name', :with => 'Christopher Harris')
    fill_in('company', :with => 'Groupon')
    fill_in('email', :with => 'email')
    fill_in('phone', :with => 'abcdefg')
    fill_in('number', :with => '4242424242424242')
    page.find_by_id('month').find("option[value='03']").click()
    page.find_by_id('year').find("option[value='2015']").click()
    fill_in('cvv', :with => '123')
    
    # submit form
    page.find(".btn-submit").click()
    
    # check errors
    expect(page.find("form .user-form-errors", :visible => false)).to be_visible
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("valid email address")
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("valid phone")
    
  end
  
  it 'should error on blank inputs (name, company, email, phone, number, month, year, cvv)', :js => true do
    subject { page }
    visit(root_path)
    wait_for_ajax
    
    # check for form
    expect(page.has_css?("form#user-form")).to eq(true)
    
    # check the URI
    uri = URI.parse(current_url)
    expect(uri.path).to eq("/")
    expect(uri.fragment).to eq("/charges/new")
    
    # submit form
    page.find(".btn-submit").click()
    
    # check errors
    expect(page.find("form .user-form-errors", :visible => false)).to be_visible
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("subscription")
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("name")
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("company") 
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("valid email address")
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("valid phone")
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("valid credit card number")
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("month")
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("year")
    expect(page.find("form .user-form-errors", :visible => false)).to have_content("valid cvv")
    
  end
  
end