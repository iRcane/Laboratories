import re
import requests

site = "http://www.mosigra.ru/"
eList = []
URLs = []
counter = 0

def Parse (URL):
  global eList
  global URLs
  global counter
  if counter < 1:
    counter = counter + 1
    page = requests.get(URL).text
    eList.extend(re.findall(r'mailto:([\w.-]+@[\w.-]+\.\w+)', page))
    URLs.append(URL)
    newURLs = set(re.findall(r'<a href=[\'\"](' + site + r'[\w./]+)', page))
    for u in newURLs:
      Parse(u)

Parse(site)
print(set(eList))
