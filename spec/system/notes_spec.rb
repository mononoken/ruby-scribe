require "rails_helper"

RSpec.describe "Notes", type: :system do
  context "when logged out" do
    before do
      sign_out :user
    end

    it "responds with 401 and redirects to login"
  end
end
