class SubmissionsController < ApplicationController
  before_action :set_course_data, only: %i[ new create ]

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to course_path(@course), notice: 'Submission was successfully created.'
    else
      render :new
    end
  end

  # GET /submissions/1/edit
  def edit
  end

  # PATCH/PUT /submissions/1 or /submissions/1.json
  def update
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_course_data
      @course = Course.find(params[:course_id])
      @enrollments = @course.enrollments.includes(:student)
      @lessons = @course.lessons
      @mentors = @course.mentors
    end
    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:lesson_id, :enrollment_id, :mentor_id, :review_result, :reviewed_at)
    end
end
