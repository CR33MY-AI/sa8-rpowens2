require 'commit'

describe Commit do
  describe "initialize" do
    it "creates a commit with valid message, author, and parent" do
      author = Author.new("Jane Doe", "janedoe@gmail.com")
      commit = Commit.new(message: "Initial commit", author: author, parent: nil)
      expect(commit.message).to eq("Initial commit")
      expect(commit.author.name).to eq("Jane Doe")
    end
    it "raises an error if message is empty" do
      author = Author.new("Jane Doe", "janedoe@gmail.com")
      expect { Commit.new(message: "", author: author, parent: nil) }.to raise_error(ArgumentError, "Message cannot be empty")
    end
    it "raises an error if author is empty" do
      expect { Commit.new(message: "Initial commit", author: nil, parent: nil) }.to raise_error(ArgumentError, "Author required")
    end
    it "generates a 12 character id" do
      author = Author.new("Jane Doe", "janedoe@gmail.com")
      commit = Commit.new(message: "Initial commit", author: author, parent: nil)
      expect(commit.id.length).to eq(12)
    end
    it "links to parent commit" do
      author = Author.new("Jane Doe", "janedoe@gmail.com")
      parent_commit = Commit.new(message: "Initial commit", author: author, parent: nil)
      child_commit = Commit.new(message: "Second commit", author: author, parent: parent_commit)
      expect(child_commit.parent).to eq(parent_commit)
    end
  end
end