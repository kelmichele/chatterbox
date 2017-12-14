class NotessController < ApplicationController
  def create
    @customer_chat = CustomerChat.includes(:recipient).find(params[:customer_chat_id])
    @note = @customer_chat.notes.create(note_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :body)
  end
end
