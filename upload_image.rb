require 'rubygems'
require 'mechanize'
require 'nokogiri'
class UploadImg
	def UploadImg.upload(img)
		@host,@enhanced_image='http://imagehost.org/',img.split(".").last
		@a=WWW::Mechanize.new
		page=@a.get(@host)
		page.form_with(:method=>'POST') do |up_form|
			up_form.file_uploads.first.file_name=img
		end.submit		
	end
 
	def UploadImg.geturl
		link=@a.get(@host+'gallery').search("//a[@target='_blank']").first['href']+".#{@enhanced_image}"
	return	link.gsub!(/\/view\//,"/")	
	end

end




