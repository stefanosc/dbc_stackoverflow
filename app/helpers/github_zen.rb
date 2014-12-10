module GithubZen
  include HTTParty
  base_uri 'https://api.github.com/zen'
  DEFAULT_USER = {
    basic_auth:{username:"#{ENV['GITHUB_USER']}", password:"#{ENV['GITHUB_PWD']}"}
  }

DEFAULT_QUOTES = ["Design for failure, enjoy your day.",
 "Responsive is better than fast, enjoy your day.",
 "Practicality beats purity, enjoy your day.",
 "Avoid administrative distraction, enjoy your day.",
 "Favor focus over features, enjoy your day.",
 "It's not fully shipped until it's fast, enjoy your day.",
 "Design for failure, enjoy your day.",
 "Mind your words, they are important, enjoy your day.",
 "Half measures are as bad as nothing at all, enjoy your day.",
 "Keep it logically awesome, enjoy your day.",
 "Favor focus over features, enjoy your day.",
 "Speak like a human, enjoy your day.",
 "It's not fully shipped until it's fast, enjoy your day."]

 def self.get_quote
  response = self.get('',DEFAULT_USER)
  if response.code == 200
    response.body
  else
    DEFAULT_QUOTES.sample
  end
 end

end



