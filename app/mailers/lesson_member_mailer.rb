class LessonMemberMailer < ApplicationMailer
  default from: 'training@mdpi.com'

  def remind(lesson_member_id)
    @lesson_member = LessonMember.find lesson_member_id
    if @lesson_member.member.user
      mail(
        to: @lesson_member.member.user.email,
        subject: '[Training] Learning reminder'
      )
    end
  end

  def assign(lesson_member_id)
    @lesson_member = LessonMember.find lesson_member_id
    if @lesson_member.member.user
      mail(
        to: @lesson_member.member.user.email,
        subject: '[Training] Lesson need learn'
      )
    end
  end

end