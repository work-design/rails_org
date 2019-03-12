class ExamJob < ApplicationJob
  queue_as :default

  def perform(exam_id)
    @exam = Exam.find exam_id
    @exam.sync_answer
  end

end
