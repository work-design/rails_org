class ExamMailer < ApplicationMailer

  def review(exam_id)
    @exam = Exam.find exam_id
    if @exam.lesson.lecturer
      mail(
        from: @exam.member.email,
        to: @exam.reviewer.email,
        subject: '[Training] Exam Finished'
      )
    end
  end

  def result(exam_id)
    @exam = Exam.find exam_id
    if @exam.member
      mail(
        to: @exam.member.user.email,
        subject: '[Training] Score come out'
      )
    end
  end

end
