require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: 'John', email: 'john@gamil.com', password: '12345678')
    @user.save
  end

  describe 'Validation tests' do
    it 'should be invalid if name is more than 20 characters' do
      @user.name = 'name>20' * 3
      @user.save
      expect(@user).to_not be_valid
    end

    it 'should be valid if name is not more than 20 characters' do
      @user.name = 'name<20'
      @user.save
      expect(@user).to be_valid
    end

    it 'should be invalid if name is nil' do
      @user.name = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it 'should be valid if name exists and not less than 5 characters' do
      @user.name = 'kelly'
      @user.save
      expect(@user).to be_valid
    end

    it 'email address should be invalid if not unique' do
      another_user = @user.dup
      another_user.email = @user.email
      another_user.save
      expect(another_user).to_not be_valid
    end

    it 'email address should be valid if unique' do
      another_user = @user.dup
      another_user.email = 'another@gmail.com'
      another_user.save
      expect(another_user).to be_valid
    end

    it 'email address should not be nil' do
      @user.email = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it 'should be valid if password is not less than 6 characters' do
      @user.password = '1234567'
      @user.save
      expect(@user).to be_valid
    end

    it 'should not be valid if password is less than 6 characters' do
      @user.password = '123'
      @user.save
      expect(@user).to_not be_valid
    end
  end

  describe 'Association Tests' do
    it 'Should not be nil when new post is created' do
      @user.posts.build(content: 'abc')
      expect(@user.reload.posts).to_not be_nil
    end

    it 'Should be nil when new post is not created' do
      @user.posts.build(content: nil)
      expect(@user.reload.posts).to eq([])
    end

    it 'Should have many relationship when two new posts are created by one user' do
      post1 = @user.posts.create!(content: 'abc')
      post2 = @user.posts.create!(content: 'def')
      expect(@user.reload.posts).to eq([post1, post2])
    end

    it 'Should not be nil when new comment is created' do
      @user.comments.build(content: 'lovely comment')
      expect(@user.reload.comments).to_not be_nil
    end

    it 'Should be nil when new comment is not created' do
      @user.comments.build(content: nil)
      expect(@user.reload.comments).to eq([])
    end 

    it 'Should not be nil when new like is created' do
      @post = @user.posts.create!(content: 'def')
      @user.likes.build(user_id: @user.id, post_id:@post.id)
      expect(@user.reload.likes).to_not be_nil
    end

    it 'Should be nil when new like is not created' do
      @post = @user.posts.create!(content: 'def')
      @user.likes.build(user_id: nil, post_id:nil)
      expect(@user.reload.likes).to_not be_nil
    end
  end
end
