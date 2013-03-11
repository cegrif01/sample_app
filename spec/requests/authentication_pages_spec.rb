require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

  describe "signin page" do
   before { visit signin_path }

   desribe "with invalid information" do
     before { click_button "Sign in" }

   describe "with valid information" do
     let(:user) { FactoryGirl.create(:user) }
     before do

       fill_in "Email", with: user.email.upcase
       fill_in "Password", with: user.email.password
       click_button "Sign in"
     end
       it { should have_selector('title', text: user.name) }
       it { should have_selector('Profile', href: user_path(user)) }
       it { should have_selector('Sign out', href: signout_path) }
       it { should have_selector('Sign in', href: signin_path) }

      end
    end
  end
end
