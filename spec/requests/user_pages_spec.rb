require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before{ visit user_path(user) }

    it{ should have_selector('h1', text: user.name) }
    it{ should have_selector('title', text: user.name) }
  end

  describe "signup page" do
    before{ visit signup_path }
    let(:submit) { "Create my account" }

    describe "signup with invalid information" do
      it "should not create a user" do    #this is how you name it. ie) bundle exec rspec spec/requests/user_pages_spec.rb \ -e "signup with valid information"
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    #test for creating a user
    describe "signup with valid information" do
      before do
        fill_in "Name",            with: "Example User"
        fill_in "Email",           with: "cegrif01@gmail.com"
        fill_in "Password",        with: "foobar"
        fill_in "Confirmation",    with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
