require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user1) { User.create(name: 'mary', email: 'mary@email.com', password: '1234567') }
  let(:user2) { User.create(name: 'greg', email: 'greg@email.com', password: '1234567') }
  let(:post1) { user1.posts.create(content: 'This is a new post!') }
  before(:each) do
    @comment = Comment.new(content: 'Awesome content', user: user1, post: post1)
    @comment.save
  end

  describe 'Validation tests' do
    it 'should be valid if content,user and posts are present' do
      expect(@comment).to be_valid
    end

    it 'should be invalid without content' do
      @comment.content=nil
      expect(@comment).to_not be_valid
    end

    it 'should be invalid without user' do
      @comment.user=nil
      expect(@comment).to_not be_valid
    end

    it 'should be invalid without post' do
      @comment.post=nil
      expect(@comment).to_not be_valid
    end

    it 'should be valid if content is not more than 200 characters' do
      @comment.content = 'great content' * 5
      @comment.save
      expect(@comment).to be_valid
    end

    it 'should be invalid if content is more than 200 characters' do
      @comment.content = 'great content' * 50
      @comment.save
      expect(@comment).to_not be_valid
    end
  end

  context '#associations' do
    it 'Should not be nil when comment is attached to a post' do
      expect(post1.reload.comments).to_not be_nil
    end

    it 'Should be nil when comment is not attached to a post' do
      post1.comments = []
      expect(post1.reload.comments).to eq([])
    end

    it 'Should be nil when comment is not attached to a user' do
      user2.comments.build(content: nil)
      expect(user2.reload.comments).to eq([])
    end

    it 'Should not be when comment is attached to a user' do
      comment3 = user2.comments.build(content: 'Its another festive period')
      expect(user2.reload.comments).to_not be_nil
    end

  end
end
