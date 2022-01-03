require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/pages/home"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /import_file" do
    describe 'when a file with unsupported content type is imported' do
      let(:file) { fixture_file_upload('screenshot.png', 'image/png') }

      it "returns an error message" do
        post pages_import_file_url, params: { filename: file }

        expect(response).to have_http_status(422)
        expect(response.parsed_body).to eq({ 'error' => 'only csv files are supported' })
      end
    end

    describe 'when a malformed csv file is imported' do
      let(:file) { fixture_file_upload('malformed.csv', 'text/csv') }

      it "returns an error message" do
        post pages_import_file_url, params: { filename: file }

        expect(response).to have_http_status(422)
        expect(response.parsed_body).to eq({ 'error' => 'Malformed CSV imported' })
      end
    end

    describe 'when a valid file is imported' do
      let(:file) { fixture_file_upload('users.csv', 'text/csv') }

      it "returns http success and creates new users" do
        expect {
          post pages_import_file_url(format: :js), params: { filename: file }
        }.to change(User, :count).by(3)
        expect(response).to have_http_status(200)
      end
    end    
  end
end
