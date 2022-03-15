require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'Validations' do
      subject {
        described_class.new(
          :email => "test1@gmail.com",
          :name => "Fotima",
          :password => "Happy123!",
          :password_confirmation => "Happy123!",
        )
      }
  
      it "Validates all fields" do
        expect(subject).to be_valid
      end
  
      it "is not valid without name" do
        subject.name = nil
        expect(subject).to_not be_valid
      end
  
      it "is not valid without email" do
        subject.email = nil
        expect(subject).to_not be_valid
      end
  
      it "is not valid without password" do
        subject.password = nil
        expect(subject).to_not be_valid
      end
  
      it "is not valid without password confirmation" do
        subject.password_confirmation = nil
        expect(subject).to_not be_valid
      end
  
      it "is not valid when password is too short" do
        subject.password = "abc"
        expect(subject).to_not be_valid
      end
  
      it "is not valid when password doesn't match with password confirmation" do
        subject.password_confirmation = "wrongpassword"
        expect(subject).to_not be_valid
      end
  
      it "checks if email is unique and case sensitive email" do
        described_class.create(
            :email => "Test1@gmail.com",
            :name => "Fotima",
            :password => "Happy123!",
            :password_confirmation => "Happy123!",
        )
        expect(subject).to_not be_valid
      end
  
    end
  
    describe '.authenticate_with_credentials' do
      it "passes if email and password match" do
        user = User.create(email: "test1@gmail.com", name: "Fotima", password: "Happy123!", password_confirmation: "Happy123!")
        @result = User.authenticate_with_credentials("test1@gmail.com", "Happy123!")
        expect(@result).to_not be_nil
      end
  
      it "passes when there are spaces and uppercase present for email" do
        user = User.create(email: "test1@gmail.com", name: "Fotima", password: "Happy123!", password_confirmation: "Happy123!")
        @result = User.authenticate_with_credentials(" Test1@gmail.com ", "Happy123!")
        expect(@result).to_not be_nil
      end
    end
  
  end