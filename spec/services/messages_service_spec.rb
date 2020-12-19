# DHP-1235
require "rails_helper"

RSpec.describe MessagesService do
  describe context "Create Message Test Cases" do
    it "should create message" do
      params = {author: Faker::Name.first_name, message: Faker::Quote.famous_last_words}
      service = MessagesService.new(params)
      service.create
      expect(service.errors.any?).to be false
      expect(Message.count).to be 1
    end

    it "should generate author can't be blank error" do
      params = {author: nil, message: Faker::Quote.famous_last_words}
      service = MessagesService.new(params)
      service.create
      expect(service.errors.any?).to be true
      expect(Message.count).to be 0
    end

    it "should generate author too long error" do
      params = {author: "a"*51, message: Faker::Quote.famous_last_words}
      service = MessagesService.new(params)
      service.create
      expect(service.errors.any?).to be true
      expect(Message.count).to be 0
    end

    it "should generate message can't be blank error" do
      params = {author: Faker::Name.first_name, message: nil}
      service = MessagesService.new(params)
      service.create
      expect(service.errors.any?).to be true
      expect(Message.count).to be 0
    end

    it "should generate message too long error" do
      params = {author: Faker::Name.first_name, message: "a"*5001}
      service = MessagesService.new(params)
      service.create
      expect(service.errors.any?).to be true
      expect(Message.count).to be 0
    end
  end

  describe context "Like Message Test Cases" do
    before do
      @message = Message.create(author: Faker::Name.first_name, message: Faker::Quote.famous_last_words)
    end

    it "should like message" do
      params = {ip_address: Faker::Internet::ip_v4_address, message_id: @message.id}
      service = MessagesService.new(params)
      service.like
      expect(service.errors.any?).to be false
      expect(Like.where(message_id: @message.id).count).to be 1
    end

    it "should generate ip address can't be blank error" do
      params = {ip_address: nil, message_id: @message.id}
      service = MessagesService.new(params)
      service.like
      expect(service.errors.any?).to be true
      expect(Like.where(message_id: @message.id).count).to be 0
    end

    it "should generate invalid ip address error" do
      params = {ip_address: "InvalidIP", message_id: @message.id}
      service = MessagesService.new(params)
      service.like
      expect(service.errors.any?).to be true
      expect(Like.where(message_id: @message.id).count).to be 0
    end

    it "should generate ip address taken error" do
      ip = Faker::Internet::ip_v4_address
      Like.create(ip_address: ip, message_id: @message.id)
      params = {ip_address: ip, message_id: @message.id}
      service = MessagesService.new(params)
      service.like
      expect(service.errors.any?).to be true
      expect(Like.where(message_id: @message.id).count).to be 1
    end

    it "should generate message must exist error" do
      params = {ip_address: Faker::Internet::ip_v4_address, message_id: rand(1000)}
      service = MessagesService.new(params)
      service.like
      expect(service.errors.any?).to be true
      expect(Like.where(message_id: @message.id).count).to be 0
    end
  end

  describe context "Top Rated Message Test Cases" do
    before do
      100.times do
        Message.create(author: Faker::Name.first_name,
                       message: Faker::Quote.famous_last_words,
                       likes: 100,
                       created_at: DateTime.now - rand(6).days - rand(10).minutes)
      end
    end

    it "should return top 5 messages of the day" do
      service = MessagesService.new({period: :day })
      service.top_messages
      result = service.top_messages_json_view[:messages].pluck(:id)
      tops = Message.where("created_at > ?", DateTime.now.beginning_of_day).order(:likes).limit(5).pluck(:id)
      expect(result).to match_array(tops)
    end

    it "should return top 5 messages of the week" do
      service = MessagesService.new({period: :week })
      service.top_messages
      result = service.top_messages_json_view[:messages].pluck(:id)
      tops = Message.where("created_at > ?", (DateTime.now - 7.days).beginning_of_day).order(:likes).limit(5).pluck(:id)
      expect(result).to match_array(tops)
    end
  end
end
