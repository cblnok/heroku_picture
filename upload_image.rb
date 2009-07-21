require 'rubygems'
require 'mechanize'
require 'nokogiri'
class UploadImg
	@@URL_UPLOAD='http://imagehost.org/'
	def initialize
		@a=WWW::Mechanize.new
		@page=@a.get(@@URL_UPLOAD)
	end#end initialize

	def upload_one_pictures(img)
		@enhanced_image=img.split(".").last #добываем разрешение изображения для
							#создания в дальнейшем горячей сцылки
		@page.form_with(:method=>'POST') do |up_form|
			up_form.file_uploads.first.file_name=img
		end.submit# собмитим загрузку пикчи
	end#end upload one

	def get_url_for_one_picture
	#незнаю почему я так сделал но мне так показалось проще :)
	link=@a.get(@@URL_UPLOAD+'gallery').search("//a[@target='_blank']").first['href']+".#{@enhanced_image}"
	#выше получили обычную ссылку она отличается от горячей присутствие куска /view/поэто мы его заменим
	#на месте на /
	hotlink=link.gsub!(/\/view\//,"/")#готовая ссылка можно вставлять в свою БД и все будет работать
	return hotlink
	end#end
end
#использование для тех кто в танке
obj=UploadImg.new
obj.upload_one_pictures('/home/cblnok/Картинки/422435_92f6c8de6c54530040ff60fecc35de5f.jpg')
obj.get_url_for_one_picture
puts obj.get_url_for_one_picture

