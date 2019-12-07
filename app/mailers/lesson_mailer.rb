class LessonMailer < ApplicationMailer

  def remind(lesson_member_id)
    @lesson_member = LessonMember.find lesson_member_id
    if @lesson_member.member.user
      mail(
        to: @lesson_member.member.user.email,
        subject: 'remind'
      )
    end
  end

end
