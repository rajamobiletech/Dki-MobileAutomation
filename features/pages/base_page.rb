class BasePage
  def initialize(calabash)
    @calabash = calabash
  end
  def current_page
   pages = @calabash.query("CordovaWebView css:'div.monelem_page'")
   z_indexs=pages.map{|page| page["html"].match(/z-index: \d+/)[0][/\d+/]}
   z_indexs.rindex(z_indexs.max)
  end
end
