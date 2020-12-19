require 'rails_helper'

RSpec.describe Like do
  before do
    @message = Message.create(author: Faker::Name.first_name, message: Faker::Quote.famous_last_words)
  end

  it "should create like" do
    like = Like.create(ip_address: Faker::Internet::ip_v4_address, message_id: @message.id)
    expect(Like.count).to eq(1)
    expect(like.errors.any?).to be false
  end

  it "should generate ip address cant be blank error" do
    like = Like.create(ip_address: nil, message_id: @message.id)
    expect(Like.count).to eq(0)
    expect(like.errors.messages[:ip_address].any?).to be true
  end

  it "should generate invalid ip address error" do
    like = Like.create(ip_address: "InvalidIP", message_id: @message.id)
    expect(Like.count).to eq(0)
    expect(like.errors.messages[:ip_address].any?).to be true
  end

  it "should generate message must exist error" do
    like = Like.create(ip_address: Faker::Internet.ip_v4_address, message_id: rand(1000))
    expect(Like.count).to eq(0)
    expect(like.errors.messages[:message].any?).to be true
  end
end