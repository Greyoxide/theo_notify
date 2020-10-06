
class PartList

  def initialize(date)
    @date = Date.parse(date.to_s).strftime("%Y/%m/%e").gsub(" ", "")
    url = "https://wol.jw.org/en/wol/dt/r1/lp-e/#{@date}"
    page = Nokogiri::HTML(HTTParty.get(url))
    @items = page.css('.bodyTxt .su').map{|r| r.text.gsub('“', '').gsub('”', '').strip}.map{|r| r.encode(Encoding.find('UTF-8'), {invalid: :replace, undef: :replace, replace: ''})}

    @items.reject! { |e| e.include? "Song" }
    @items.reject! {|e| e.include? "Opening Comments"}
    @items.reject! {|e| e.include? "min. or less"}

  end

  def append_extras
    self.items.unshift("Chairman")
    self.items.unshift("Opening Prayer")
    self.items << "Bible Study Reader" << "Closing Prayer"
  end

  attr_accessor :date, :items

end
