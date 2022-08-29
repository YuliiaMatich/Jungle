require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user validations' do
    let (:user) {User.new(name: 'john', email: 'john@john.com', password: 'john', password_confirmation: 'john')}

    it "valid user" do
      expect(user).to be_valid
    end

    it "invalid password" do
      user.password_confirmation = 'doe'
      expect(user).to be_invalid
    end

    it "name presence" do
      user.name = nil
      expect(user).to be_invalid
    end

    it "email presence" do
      user.email = nil
      expect(user).to be_invalid
    end

    it "8 char validation of pw" do
      user.password = 'jjjjjjjjjj'
      expect(user).to be_invalid
    end

    it "min 3 characters validation" do
      user.password = 'j'
      expect(user).to be_invalid
    end

    it 'unique email validation' do
      @user = User.new(name: 'John John', email: 'john@john.com', password: 'john', password_confirmation: 'john')
      @user.save!
      @user1 = User.new(name: 'Jane', email: 'JOHN@john.com', password: 'jane', password_confirmation: 'jane')
      expect(@user1).to_not be_valid
      expect(@user1.errors.full_messages).to include('Email has already been taken')
    end
  end

  describe 'auth with credentials' do
    let(:user) {User.new(name: "john", email: "john@john.com", password: "john", password_confirmation: "john")}

    it "returns true when authenticated" do
      user.save!
      @new_login = user.authenticate_with_credentials("john@john.com", "john")
      expect(@new_login).to be_truthy
    end

    it "returns false when email is incorrect" do
      user.save!
      @new_login = user.authenticate_with_credentials("jane@john.com", "john")
      expect(@new_login).to be_falsey
    end

    it "returns false when password is incorrect" do
      user.save!
      @new_login = user.authenticate_with_credentials("john@john.com", "jane")
      expect(@new_login).to be_falsey
    end

    it "returns truthy when auth with email with spaces around" do
      user.save!
      @new_login = user.authenticate_with_credentials("    john@john.com    ", "john")
      expect(@new_login).to be_truthy
    end

    it "returns truthy when email has different casing" do
      user.save!
      @new_login = user.authenticate_with_credentials("JOHN@john.com", "john")
      expect(@new_login).to be_truthy
    end

    it "returns nil when email and pw are not found" do
      user.save!
      @new_login = user.authenticate_with_credentials("john@jane.com", "john")
      expect(@new_login).to be_nil
    end    
  end
end
