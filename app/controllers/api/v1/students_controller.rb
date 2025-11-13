class Api::V1::StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    student = {
      id: 123,
      first_name: "Marge",
      last_name: "Simpson",
      email: "marge@simpsons.com"
    }

    render json: { student: student }, status: :created
  end
end
