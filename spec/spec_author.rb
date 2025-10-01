require 'author'

describe Author do
  describe "initialize" do
    it "creates an Author with valid name and email" do
      author = Author.new("Jane Doe", "janedoe@gmail.com")
      expect(author.name).to eq("Jane Doe")
      expect(author.email).to eq("janedoe@gmail.com")
    end
    it "raises an error if name is empty" do
      expect { Author.new("", "janedoe@gmail.com")}.to raise_error(ArgumentError, "Name cannot be empty")
    end
    it "raises an error if email is empty" do
      expect { Author.new("Jane Doe", "")}.to raise_error(ArgumentError, "Email cannot be empty")
    end
    it "raises an error if email format is invalid" do
      expect { Author.new("Jane Doe", "janedoe.gmail.com")}.to raise_error(ArgumentError, "Invalid email format")
    end
  end
end