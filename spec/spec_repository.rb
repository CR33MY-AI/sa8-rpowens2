require 'repository'

describe Repository do
  describe "initialize" do
    it "creates a Repository with a default 'main' branch and empty commits" do
      repo = Repository.new
      expect(repo.branches).to have_key("main")
      expect(repo.branches["main"]).to be_nil
      expect(repo.current_branch).to eq("main")
    end
  end
  describe "create_branch" do
    it "creates a new branch with a valid name" do
      repo = Repository.new
      repo.create_branch("feature")
      expect(repo.branches).to have_key("feature")
    end
    it "raises an error if branch name is empty" do
      repo = Repository.new
      expect { repo.create_branch("") }.to raise_error(ArgumentError, "Branch name cannot be empty")
    end
    it "raises an error if branch already exists" do
      repo = Repository.new
      repo.create_branch("feature")
      expect { repo.create_branch("feature") }.to raise_error(ArgumentError, "Branch 'feature' already exists")
    end
  end
  describe "branch" do
    it "returns the head commit id of an existing branch" do
      repo = Repository.new
      expect(repo.branch("main")).to be_nil
    end
  end
  describe "switch" do
    it "switches to an existing branch" do
      repo = Repository.new
      repo.create_branch("feature")
      repo.switch("feature")
      expect(repo.current_branch).to eq("feature")
    end
  end
  describe "log" do
    it "returns an empty array for a branch with no commits" do
      repo = Repository.new
      expect(repo.log("main")).to be_empty
    end
    it "returns commits in reverse chronological order" do
      author = Author.new("Jane Doe", "janedoe@gmail.com")
      repo = Repository.new
      commit1 = repo.commit!(message: "Initial commit", author: author)
      commit2 = repo.commit!(message: "Second commit", author: author)
      log = repo.log("main")
      expect(log).to eq([commit2, commit1])
    end
  end
end