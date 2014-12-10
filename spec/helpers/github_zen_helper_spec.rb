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
  WebMock.stub_request(:get, "https://overflow-api:12345678o@api.github.com/zen").
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => "dsaf", :headers => {})

    end
  end

  p GithubZen.get_quote
end
