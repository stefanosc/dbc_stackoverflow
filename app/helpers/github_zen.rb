module GithubZen
  include HTTParty
  base_uri 'https://api.github.com/zen'
  DEFAULT_USER = {
    basic_auth:{username:"#{ENV['GITHUB_USER']}", password:"#{ENV['GITHUB_PWD']}"}
  }

DEFAULT_QUOTES = ["Design for failure.",
 "Responsive is better than fast.",
 "Practicality beats purity.",
 "Avoid administrative distraction.",
 "Favor focus over features.",
 "It's not fully shipped until it's fast.",
 "Design for failure.",
 "Mind your words, they are important.",
 "Half measures are as bad as nothing at all.",
 "Keep it logically awesome.",
 "Keep it logically awesome.",
 "Favor focus over features.",
 "Speak like a human.",
 "It's not fully shipped until it's fast."]

 def self.get_quote
  response = self.get('',DEFAULT_USER)
  if response.code == 200
    response.body
  else
    DEFAULT_QUOTES.sample
  end
 end

end



