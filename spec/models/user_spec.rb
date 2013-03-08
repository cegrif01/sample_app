# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", 
  							password: "foobar", password_confirmation: "foobar") }

  subject{ @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it{ should be_valid }

#basically we are testing if our application will allow the things
#in the before statement to pass.  If we have proper validation
#in the model, then the conditions in the before statement won't be
#able to happen and thus pass the test.  If these conditions in the 
#before statement are allowed to happen then the it will fail because
#the statement in the it method, will kick it out

  describe "when name is not present" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

   describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when name is too long" do
  	before { @user.name = "a" *51 } #condition that will definitely fail
  	it { should_not be_valid } #test if our application will allow such a thing to happen
  	#Think of the it statment to be the big boss to see if subordinate supervisor (our app)
  	#will allow such an attrocity to happen.  A failure of course occurs when the app allows
  	#dumb things like this to happen!
  end

  describe "when email format is invalid" do
	  it "should be invalid" do 
	  		addresses = %w[user@foo,com user_at_foo.org example.user@foo.
	  					foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end

  describe "when email format is valid" do
	  it "should be valid" do 
	  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end

	describe "when email address is already taken" do
	    before do
	      user_with_same_email = @user.dup  #creates a user with the same email attribute
	      user_with_same_email.email = @user.email.upcase
	      user_with_same_email.save
	    end

	    it { should_not be_valid }
	  end

  	describe "when password is not present" do
  		before { @user.password = @user.password_confirmation = " " }
  		it { should_not be_valid }
  	end

  	describe "when passwords don't match" do
  		before { @user.password_confirmation = "mismatch" }
  		it { should_not be_valid }
  	end

  	describe "when password confirmation is nil" do
  		before { @user.password_confirmation = nil }
  		it { should_not be_valid }
  	end
end
