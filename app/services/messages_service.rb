class MessagesService
  attr_reader :errors

  def initialize(params)
    @params = params
    @errors = []
  end

  def create
    @message = Message.create(@params)
    set_errors(@message)
  end

  def like
    find_message
    create_like
  end

  def top_messages
    date_param = @params[:period] == :week ? (DateTime.now - 1.week).beginning_of_day : DateTime.now.beginning_of_day
    @top_messages = Message.select("id, author, message, likes, created_at")
                           .where("created_at > ?", date_param)
                           .order(:likes)
                           .limit(5)
  end

  def messages_feed
    @messages = Message.select("id, author, message, likes, created_at")
                       .order("created_at DESC")
                       .page(@params[:page].to_i)
                       .per(PAGE_LIMIT)
  end

  def create_json_view
    {message: @message.as_json(except: [:lock_version])}
  end

  def like_json_view
    {like: @like.as_json}
  end

  def top_messages_json_view
    {messages: @top_messages}
  end

  def messages_feed_json_view
    {messages: @messages}
  end
  private

  def find_message
    @message = Message.find_by(id: @params[:message_id])
    @errors << "Message not found" if @message.nil?
  end

  def create_like
    return if @errors.any?
    ActiveRecord::Base.transaction do
      @like = Like.create(@params)
      increase_message_likes
      raise ActiveRecord::Rollback if @like.errors.any? || @message.errors.any?
    end
    set_errors(@like)
    set_errors(@message)
  end

  def increase_message_likes
      @message.increase_likes
    rescue ActiveRecord::StaleObjectError
      @message.reload
      retry
  end

  def set_errors(object)
    @errors.concat(object.errors.full_messages)
  end
end