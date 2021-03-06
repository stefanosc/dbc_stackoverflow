require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the GithubZenHelper. For example:
#
# describe GithubZenHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe GithubZen, :type => :helper do

  describe "GithubZen.get_quote" do
    context "when not rate limited" do
      WebMock.stub_request(:get, "https://overflow-api:12345678o@api.github.com/zen").with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).to_return(:status => 200, :body => "random quote", :headers => {})
      it "returns a new random quote" do
        expect(GithubZen.get_quote).to  eq("random quote")
      end
    end
    context "when rate limited" do
      WebMock.stub_request(:get, "https://overflow-api:12345678o@api.github.com/zen").with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).to_return(:status => 403, :body => "from the array of built in quotes", :headers => {})
      it "returns a quote from the array of built" do
        expect(GithubZen.get_quote).to eq("from the array of built in quotes")
      end
    end
  end

end
