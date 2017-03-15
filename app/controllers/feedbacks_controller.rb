class FeedbacksController < InheritedResources::Base

  before_action :authenticate_user!

  def create
    feedback = Feedback.new(feedback_params)
    feedback.user = current_user
    if feedback.save
      feedback.send_to_admin
      redirect_to root_path, flash: { notice: 'Ваше сообщение сохранено. В скором времени Вам ответит администратор.' }
    else
      @feedback = feedback
      render :new
    end
  end

  private

    def feedback_params
      params.require(:feedback).permit(:feedback_text)
    end
end

