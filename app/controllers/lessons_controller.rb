class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_to_view_lesson

  def show
  end

  private

  def require_authorized_to_view_lesson

    this_course = current_lesson.section.course

    if !current_user.enrolled_in?(this_course) && this_course.user != current_user
      redirect_to course_path(current_lesson.section.course), alert: 'You are not enrolled in this course!'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

end