require "rails_helper"

RSpec.describe NotesHelper, type: :helper do
  describe NotesHelper::FaeScribeRenderer do
    subject(:renderer) { described_class.new }

    describe "#link" do
      let(:url) { "https://localhost:9000/stuff" }
      let(:title) { "title " }
      let(:content) { "content" }

      it "returns populated anchor element" do
        populated_template = %(<a href="#{url}">#{content}</a>)

        expect(renderer.link(url, title, content)).to eq(populated_template)
      end
    end

    describe "#paragraph" do
      let(:text) { "some content" }

      it "returns <p> with text and linebreak" do
        expected = %(<p>#{text}</p>\n)
        expect(renderer.paragraph(text)).to eq(expected)
      end

      context "when text includes an internal link to existing note" do
        let(:note) { create(:note) }
        let(:text) { "This text contains an internal link to [[#{note.name}]]" }
        let(:note_url) { note_path(note) }

        it "converts all internal links within text" do
          expected =
            %(<p>This text contains an internal link to <a href="#{note_url}">#{note.name}</a></p>\n)
          expect(renderer.paragraph(text)).to eq(expected)
        end
      end

      context "when text includes an internal link to nonexistent note" do
        let(:text) { "This text contains an internal link to [[does not exist]]" }

        it "returns <p> with text without link conversion" do
          expected = %(<p>#{text}</p>\n)
          expect(renderer.paragraph(text)).to eq(expected)
        end
      end
    end

    describe "#list_item" do
      let(:text) { "some content" }
      let(:list_type) { :unordered }

      it "returns <li> with text and linebreak" do
        expected = %(<li>#{text}</li>\n)
        expect(renderer.list_item(text, list_type)).to eq(expected)
      end

      context "when text includes an internal link to existing note" do
        let(:note) { create(:note) }
        let(:text) { "This text contains an internal link to [[#{note.name}]]" }
        let(:note_url) { note_path(note) }

        it "converts all internal links within text" do
          expected =
            %(<li>This text contains an internal link to <a href="#{note_url}">#{note.name}</a></li>\n)
          expect(renderer.list_item(text, list_type)).to eq(expected)
        end
      end

      context "when text includes an internal link to nonexistent note" do
        let(:text) { "This text contains an internal link to [[does not exist]]" }

        it "returns <li> with text without link conversion" do
          expected = %(<li>#{text}</li>\n)
          expect(renderer.list_item(text, list_type)).to eq(expected)
        end
      end
    end

    describe "#header" do
      let(:text) { "some content" }
      let(:level) { rand(1..4) }
      let(:tag) { "h#{level}" }

      it "returns header element with text and linebreak" do
        expected = %(<#{tag}>#{text}</#{tag}>)
        expect(renderer.header(text, level)).to eq(expected)
      end

      context "when text includes an internal link to existing note" do
        let(:note) { create(:note) }
        let(:text) { "This text contains an internal link to [[#{note.name}]]" }
        let(:note_url) { note_path(note) }

        it "converts all internal links within text" do
          expected =
            %(<#{tag}>This text contains an internal link to <a href="#{note_url}">#{note.name}</a></#{tag}>)
          expect(renderer.header(text, level)).to eq(expected)
        end
      end

      context "when text includes an internal link to nonexistent note" do
        let(:text) { "This text contains an internal link to [[does not exist]]" }

        it "returns header element with text without link conversion" do
          expected = %(<#{tag}>#{text}</#{tag}>)
          expect(renderer.header(text, level)).to eq(expected)
        end
      end
    end
  end
end
