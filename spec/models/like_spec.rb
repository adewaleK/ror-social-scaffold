require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) { User.create(name: 'mary', email: 'mary@email.com', password: '1234567') }
  let(:user2) { User.create(name: 'jonny', email: 'j@email.com', password: '1234567') }
  let(:post1) { user1.posts.create(content: 'This is a new post!') }
  let(:post2) { Post.create(content: 'last post!') }
  let(:comment1) { post1.comments.create(user_id: 1, content: 'This is a new post!') }
  let(:like1) { user1.likes.create(post_id: 1) }

  context 'Validation tests' do
    it 'Ensures presence of user in creating likes' do
      like = Like.new(user: user1).save
      expect(like).to eq(false)
    end

    it 'Ensures presence of post in creating likes' do
      like = Like.new(post: post1).save
      expect(like).to eq(false)
    end

    it 'Ensures presence of both user and post in creating likes' do
      like = Like.new(user: user1, post: post1).save
      expect(like).to eq(true)
    end
  end

  context 'check associations' do
    it 'should obtain user\s likes' do
      expect(user1.likes).to eq([like1])
    end

    it 'should obtain empty list of user/s list' do
      expect(user2.likes).to eq([])
    end

    it 'should obtain post\s likes' do
      expect(post1.likes).not_to be_nil
    end

    it 'should obtain empty list of posts/s list' do
      expect(post2.likes).to eq([])
    end
  end
end
