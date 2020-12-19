require 'rails_helper'

RSpec.describe Message do
  it "should create message" do
    message = Message.create(author: Faker::Name.first_name, message: Faker::Quote.famous_last_words)
    expect(Message.count).to eq(1)
    expect(message.errors.any?).to be false
  end

  it "should generate author can't be blank error" do
    message = Message.create(author: nil, message: Faker::Quote.famous_last_words)
    expect(Message.count).to eq(0)
    expect(message.errors.messages[:author].any?).to be true
  end

  it "should generate author is too long error" do
    message = Message.create(author: "a"*51, message: Faker::Quote.famous_last_words)
    expect(Message.count).to eq(0)
    expect(message.errors.messages[:author].any?).to be true
  end

  it "should generate message can't be blank error" do
    message = Message.create(author: Faker::Name.first_name, message: nil)
    expect(Message.count).to eq(0)
    expect(message.errors.messages[:message].any?).to be true
  end

  it "should generate message is too long error" do
    message = Message.create(author: Faker::Name.first_name, message: "a"*5001)
    expect(Message.count).to eq(0)
    expect(message.errors.messages[:message].any?).to be true
  end
end