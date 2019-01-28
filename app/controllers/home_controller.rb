class HomeController < ApplicationController
  require 'mechanize'
  
  def index
  end

  def user_data
    agent = Mechanize.new
    page = agent.get('https://uni.likelion.org')
    
    my_page = page.form_with(:action => "/users/sign_in") do |f|
    # 페이지에서 users/sing_in이라는 액션을 찾아서 그 값을 my_page에 넣는다?
        f.field_with(:name => "user[email]").value = "chaehanna@likelion.org" # 해당하는 필드에서 이름이 어떤건지 가져온다
        f.field_with(:name => "user[password]").value = "62534109"
    end.submit
    
    1143.downto(1).each do |x|
      begin
      # 이상 없을 때
         @user = User.new
         
         page2 = agent.get("https://uni.likelion.org/users/#{x}") # 1143번째 페이지를 연다
         
         page2.search("#main > header > div > div > h1").map(&:text).each do |n|
           @user.name = n
         end
         page2.search("#main > header > div > p:nth-child(2) > span").map(&:text).each do |e|
           @user.email = e
         end
         page2.search("#main > header > div > p.meta.mt-2 > span").map(&:text).each do |s|
           @user.subtitle = s
         end
         page2.search("#main > section > div > section > div").map(&:text).each do |c|
           @user.content = c
         end
         @user.number = x
         
         @user.save
        
      rescue Mechanize::ResponseCodeError => e
      # 이상 있을 때(오류난 내용을 e에 저장)
      end
    end
  
    redirect_to "/home/user_view"
        # .map(&:text) // 그 안(selector)의 글씨만 뺀다
        
  end

  def idea_data
     agent = Mechanize.new
    page = agent.get('https://uni.likelion.org')
    
    my_page = page.form_with(:action => "/users/sign_in") do |f|
    # 페이지에서 users/sing_in이라는 액션을 찾아서 그 값을 my_page에 넣는다?
        f.field_with(:name => "user[email]").value = "chaehanna@likelion.org" # 해당하는 필드에서 이름이 어떤건지 가져온다
        f.field_with(:name => "user[password]").value = "62534109"
    end.submit
    
    278.downto(1).each do |x|
      begin
      # 이상 없을 때
         @idea = Idea.new
         
         page2 = agent.get("https://uni.likelion.org/ideathon/ideas/#{x}") # 1143번째 페이지를 연다
         
         page2.search("#header > div > div > div > h1").map(&:text).each do |t|
           @idea.title = t
         end
         page2.search("#header > div > div > div > p").map(&:text).each do |s|
           @idea.subtitle = s
         end
         page2.search("#header > div > div > div > div.header__info > div:nth-child(1) > p").map(&:text).each do |v|
           @idea.vote = v
         end
        # 팀장의 주소 불러오기
        page2.search("#header > div > div > div > div.header__info__members > div > div > a").each do |c|
           @idea.cap = c['href'].split("/").last # href값(/users/79)만 불러오겠다.
         end
         @idea.number = x
         
         @idea.save
        
      rescue Mechanize::ResponseCodeError => e
      # 이상 있을 때(오류난 내용을 e에 저장)
      end
    end
  
    redirect_to "/home/idea_view"
        # .map(&:text) // 그 안(selector)의 글씨만 뺀다
        
  end

  def user_view
    @user = User.all
  end

  def idea_view
    @idea = Idea.all
  end
end
