class ExamGenerateJob < ApplicationJob
  queue_as :default

  def perform(exam_id)
    @exam = Exam.find exam_id
    @exam.custom_link
  end

end
