class Scraping
   def self.movie_urls
    # 映画の個別ページのURLを取得
    # get_product(link)を呼び出す
    links = []
    agent = Mechanize.new
    next_url = ""

    while true do
      current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)
      elements = current_page.search('.entry-title a')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      next_ink = current_page.at('.pagination .next a')
      break unless next_ink
        next_url = next_ink.get_attribute('href')
    end

    links.each do |link|
      get_product('http://review-movie.herokuapp.com/' + link)
    end
  end

    def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.entry-title').inner_text if page.at('.entry-title')

    image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
    director = page.at('.director span').inner_text if page.at('.director span')
    detail = page.at('.entry-content p').inner_text if page.at('.entry-content p')
    open_date = page.at('.date span').inner_text if page.at('.date span')

    product = Product.where(title: title).first_or_initialize
        #first_or_initializeメソッドはwhereメソッドと共に使うことで検索した条件のレコードがあればそのレコードのインスタンスをかえし、なければ新しくインスタンスを作ってくれるメソッド
    product.image_url = image_url
    product.director = director
    product.detail = detail
    product.open_date = open_date
    product.save
  end
end





    # class Scraping
    #   def self.movie_urls
    #     #①linksという配列の空枠を作る
    #     #②Mechanizeクラスのインスタンスを生成する
    #     #③映画の全体ページのURLを取得
    #     #④全体ページから映画20件の個別URLのタグを取得
    #     #⑤個別URLのタグからhref要素を取り出し、links配列に格納する
    #     #⑥get_productを実行する際にリンクを引数として渡す
    #   end

    #   def self.get_product(link)
    #     #⑦Mechanizeクラスのインスタンスを生成する
    #     #⑧映画の個別ページのURLを取得
    #     #⑨inner_textメソッドを利用し映画のタイトルを取得
    #     #①⓪image_urlがあるsrc要素のみを取り出す
    #     #①①newメソッド、saveメソッドを使い、 スクレイピングした「映画タイトル」と「作品画像のURL」をproductsテーブルに保存
    #   end
    # end