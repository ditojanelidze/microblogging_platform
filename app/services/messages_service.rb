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
    @like = Like.create(@params)
    set_errors(@like)
  end

  def create_json_view
    {message: @message.as_json}
  end

  def like_json_view
    {like: @like.as_json}
  end

  private

  def set_errors(object)
    @errors.concat(object.errors.full_messages)
  end
end