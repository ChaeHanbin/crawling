require 'mechanize'

agent = Mechanize.new
page = agent.get('https://uni.likelion.org')

my_page = page.form_with(:action => "/users/sign_in") do |f|
# 페이지에서 users/sing_in이라는 액션을 찾아서 그 값을 my_page에 넣는다?
    f.field_with(:name => "user[email]").value = "chaehanna@likelion.org" # 해당하는 필드에서 이름이 어떤건지 가져온다
    f.field_with(:name => "user[password]").value = "62534109"
end.submit



# https://uni.likelion.org/users/102
# 이 값을 가져오자

page2 = agent.get("https://uni.likelion.org/users/1143") # 1143번째 페이지를 연다
    # page2.search("#main > header > div > div > h1").map(&:text).each do |p| # 그 안(selector)의 글씨만 뺀다
    # end
    
name = page2.search("#main > header > div > div > h1").map(&:text)
email = page2.search("#main > header > div > p:nth-child(2) > span").map(&:text)
subtitle = page2.search("#main > header > div > p.meta.mt-2 > span").map(&:text)
content = page2.search("#main > section > div > section > div").map(&:text)
# number = page2.search("").map(&:text)

puts name + email + subtitle + content
# 엑셀파일 등 외부파일로 뽑고 싶을 때는?
# CSV.open("file.csv", "wb") do |csv|
#   csv << ..........
        