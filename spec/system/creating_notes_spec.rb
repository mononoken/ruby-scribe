require "rails_helper"

RSpec.describe "creating notes", type: :system do
  let(:note) { create(:note) }

  context "when user has an empty journal" do
    xit "creates first note"
  end
end
