require 'rubygems'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.canada.gc.ca/depts/major/depind-eng.html'))

# Do funky things with it using Nokogiri::XML::Node methods...

wet_count = 0
clf_count = 0
nonwet_count = 0
unreadsite_count = 0

####
# Search for nodes by css
doc.css('div#cn-centre-col-inner section ul li a').each do |link| 
  puts link.content 
  # puts link['href']
  url = link['href'].strip
  
  begin  
    source = open(url).read
    
    if source =~ /Web Experience Toolkit \(WET\)/
      wet_count = wet_count + 1
    elsif source =~ /CLF 2.0 TEMPLATE VERSION/
      clf_count = clf_count + 1
    else  
      nonwet_count = nonwet_count + 1 
    end

  rescue Exception
    puts "Unable to read site: " + url + unreadsite_count.to_s
  end
end

puts
puts 'Sites using WET: ' + wet_count.to_s
puts 'Sites using CLF 2.0 template: ' +clf_count.to_s
puts
puts 'Sites not using Standardized templates: ' + nonwet_count.to_s





