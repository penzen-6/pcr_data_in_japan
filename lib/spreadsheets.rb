require 'bundler'
Bundler.require

# require 'open-uri'
# require 'nokogiri'

session = GoogleDrive::Session.from_service_account_key("client_seacret.json")
spreadsheet = session.spreadsheet_by_title("PCR_test")
worksheet = spreadsheet.worksheets.first

over_hundred = 0 
test_counter = 0

worksheet.rows.each_with_index do |rows, i|
    test_count = rows[1].to_i
    test_counter += test_count

    if test_count > 100000
        over_hundred += 1
    end
end

puts "検査数が10万件を超えた日数　#{over_hundred}"
puts "これまでのPCR検査数 #{test_counter}"

worksheet.save


# scraping template

=begin

url = ''    # target url

charset = nil
html = URI.open(url) do |f|
    charset = f.charset
    f.read
end

# create object a html parsed
doc = Nokogiri::HTML.parse(html, nil, charset)

# get *** count
doc.xpath('//td[@class="price"]').each_with_index do |node, i|
    p node.css('a').attribute('href').value
    break if i == 100
end

=end