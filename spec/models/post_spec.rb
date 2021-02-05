require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user1) { User.create(name: 'Jamezjaz', email: 'microverse@email.com', password: '1234567') }
  let(:user2) { User.create(name: 'Idris', email: 'id@email.com', password: '1234567') }
  let(:post1) { user1.posts.create(content: 'This is a new post!') }
  let(:post2) { Post.create(content: 'This is a special post!') }
  let(:like2) { post1.likes.create(user_id: user1.id) }
  let(:comment1) { post1.comments.create(user_id: 1, content: 'This is a new post!') }
  let(:like1) { user1.likes.create(post_id: 1) }

  context '#associations' do
    it 'obtain the posts of the author' do
      expect(user1.posts).to eq([post1])
    end

    it 'returns empty list for users without posts' do
      expect(user2.posts).to eq([])
    end

    it 'obtain comments belonging to a post' do
      expect(post1.comments).to eq([comment1])
    end

    it 'returns empty list for a post without comments' do
      expect(post2.comments).to eq([])
    end

    it 'should exist a like for post1' do
      expect(post1.likes).to eq([like2])
    end

    it 'should return empty likes for post2' do
      expect(post2.likes).to eq([])
    end
  end
end
