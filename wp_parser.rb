require 'nokogiri'
require 'html5-beautifier'
require_relative 'tools'

class String
  def clean_tags
    clean = self
    clean.gsub!(/(?:<p>)?<span class="full-image-block ssNonEditable"><span>(.*?)<\/span><span class="thumbnail-caption".*?>(.*?)<\/span><\/span>(?:(<\/p>|<br \/>))/,
      '<div class="image_in_post">\1<div class="image_caption">\2</div></div>')
    clean.gsub!(/\[caption id="" align="alignnone" width="500" caption=(.*?)\](.*?)\[\/caption\]/,
      '<div class="image_in_post">\2<div class="image_caption">\1</div></div>')
    clean.gsub!(/\[youtube (.*?)\]/,
      '<iframe width="640" height="390" src="\1" frameborder="0" allowfullscreen></iframe>')
    clean.gsub!('<br/>', '')
    clean
  end
end


filename = ARGV[0] || ask("What file do you want to parse?")

begin
  wpfile = File.new(filename)
rescue
  puts "Unable to open file '#{filename}'"
  return false
end

posts = []
current_post = {}

wpfile.each do |line|
  case line
  when /<title>(.*?)<\/title>/
    current_post[:title] = $1
  when /<pubDate>(.*?)<\/pubDate>/
    current_post[:date] = $1
  when /<content:encoded><!\[CDATA\[(.*)/
    current_post[:content] = $1
    @content = true
  when /(.*?)\]\]><\/content:encoded>/
    current_post[:content] += $1
    posts.push current_post
    @content = false
    current_post = {}
  else
    current_post[:content] += line if @content
  end
end

user = User.find_by_name("Brent")

posts.each do |post|
  puts "Title: #{post[:title]}"
  puts "Date: #{post[:date]}"
  clean_content = Nokogiri::HTML::DocumentFragment.parse(post[:content].clean_tags).to_xml
  comment = "<!-- This Blog was auto-generated from a wordpress site - formatting may suck -->\n"
  content = comment + clean_content
  puts "Content:\n#{content}"
  puts "-"*20
  if( ask("Add this post?") =~ /^y/i )
    user.blogs.build(title: post[:title], posting_date: Date.parse(post[:date]), content: content)
    user.save!
  end
end

