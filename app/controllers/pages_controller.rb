class PagesController < ApplicationController
  def home
  end

  def import_file
    content_type = params[:filename].content_type
    if content_type != 'text/csv'
      render json: { error: 'only csv files are supported'}, status: 422 
    else
      file = params[:filename].tempfile
      @data = UserImport.create_bulk_users(file)
    end
    rescue CSV::MalformedCSVError => e
      render json: { error: "Malformed CSV imported" }, status: 422
  end 
end
