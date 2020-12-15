require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) { User.create(name: 'joper', email: 'jsjxxs@jsjsee.com', password: 'passworddd') }
  let(:user2) { User.create(name: 'jopexxr', email: 'jsjs@jsjsee.com', password: 'passwor2ddd') }
  let(:rec) { user1.friendships.build(sent_to_id: user2.id, confirmed: false) }

  describe '#valides' do
    it 'validates friendship instance mmm' do
      friendship = Friendship.new(sent_by: user1, sent_to: user2).save
      expect(friendship).to eq(true)
    end
    it 'validates friendship instance' do
      friendship = Friendship.new(sent_to: user1).save
      expect(friendship).to eq(false)
    end
  end

  describe '#association' do
    let(:user1) { User.create(name: 'Jamezjaz', email: 'microverse@email.com', password: '1234567') }
    let(:user2) { User.create(name: 'Chigozie', email: 'rails@email.com', password: '1234567') }
    let(:friend1) { user1.friend_sent.create(sent_to: user2) }

    it 'frienship belongs to a user' do
      user1
      user2
      friend1
      expect(Friendship.first.sent_by).not_to be_nil
    end
  end
end
