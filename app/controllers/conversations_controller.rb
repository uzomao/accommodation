class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.all
    # if @conversations.length == 0
    #   render action: 'create' and return
    # end
      
  end


  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    p @conversation

    redirect_to conversation_messages_path(@conversation)
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end

end
