require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create(first_name: "Test", last_name: "User", email: "test@test.com", password: "abc123", password_confirmation: "abc123") } 
  subject { 
    described_class.new(first_name: "Test", last_name: "User", email: "email@mail.com", password: "abc123", password_confirmation: "abc123")
   }
   

  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a matching password" do
      subject.password_confirmation = "123abc"
      expect(subject).to_not be_valid
    end

    it "is not valid without a password and confirmation" do
      subject.password = nil
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a unique email (case insensitive)" do
      subject.email = "test@test.COM"
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password length of 5 characters" do
      subject.password = "12345"
      expect(subject).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do

    it "is valid with correct login info" do      
      @return_val = User.authenticate_with_credentials(user.email, user.password)
      expect(user).to eq(@return_val)
    end

    it "is valid with regardless of spaces in front and end" do     
      user.email = "  test@test.com  "
      @return_val = User.authenticate_with_credentials(user.email, user.password)
      expect(user).to eq(@return_val)
    end

    it "is valid with regardless of case sensitivity" do      
      user.email = "tEsT@teST.COM"
      @return_val = User.authenticate_with_credentials(user.email, user.password)
      expect(user).to eq(@return_val)
    end

    it "is not valid with wrong email" do      
      user.email = "wrong@test.com"
      @return_val = User.authenticate_with_credentials(user.email, user.password)
      expect(user).to_not eq(@return_val)
    end

    it "is not valid with wrong password" do      
      user.password = "dsfsdfdsfdsf"
      @return_val = User.authenticate_with_credentials(user.email, user.password)
      expect(user).to_not eq(@return_val)
    end
  end
end
