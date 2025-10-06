class TrimestersController < ApplicationController

  def index
    @trimesters = Trimester.all
  end

  def show
    @trimester = Trimester.find(params[:id])
  end

  def edit
    @trimester = Trimester.find(params[:id])
  end

  def update
    @trimester = Trimester.find_by(id: params[:id])
    return render plain: "Trimester not found", status: :not_found unless @trimester

    input = params[:trimester][:application_deadline]

    if input.blank?
      @trimester.errors.add(:application_deadline, "cannot be blank")
      return render :edit, status: :bad_request
    end

    unless valid_date?(input)
      @trimester.errors.add(:application_deadline, "must be a valid date")
      return render :edit, status: :bad_request
    end

    if @trimester.update(application_deadline: input)
      redirect_to @trimester, notice: "Application deadline updated successfully."
    else
      @trimester.errors.add(:application_deadline, "could not be updated")
      render :edit, status: :bad_request
    end
  end

  private

  def valid_date?(value)
    Date.parse(value)
    true
  rescue ArgumentError
    false
  end
end