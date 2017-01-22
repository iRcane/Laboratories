require 'net/http'

$site = "http://www.mosigra.ru/"
$eArray = []
$URLs = []
$counter = 0

def Parse(obj)
	if ($counter < 10) then
		$counter += 1
		$URLs.push(obj)
		
		regExpE = /mailto:([[[:word:]].-]+@[[[:word:]].-]+\.[[:word:]]+)/
		regExpU = Regexp.new('<a href=[\'\"](' + $site + '[[[:word:]]./]+)')
		url = URI.parse(obj)
		req = Net::HTTP::Get.new(url.to_s)
		res = Net::HTTP.start(url.host, url.port) {|http|
			http.request(req)}
		page = res.body
	
		for e in page.scan(regExpE) 
			unless ($eArray.include?(e.join(",")))
				$eArray.push(e.join(","))
			end
		end
		newURLs = page.scan(regExpU).uniq
		for u in newURLs
			unless ($URLs.include?(u.join("")))
				Parse(u.join(""))
			end
		end
	end
end

Parse($site)
print($eArray)
#print($URLs)