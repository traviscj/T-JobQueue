#!/usr/bin/python
import os
import sys
import urllib, httplib2

###prototypical output..
#file0: hello.sh
#link0: http://traviscj.com/job_queue/codes/hello.sh
#compile0: 
#command: bash hello.sh
#random key: xyz123

def main():
	import urllib
	http = httplib2.Http()
	DOWNLOADS = {}
	COMPILES = {}
	COMMAND = ""
	data = urllib.urlopen("http://traviscj.com/job_queue/queue.py")
	dataArray = data.readlines()
	i=0
	while i < len(dataArray):
		if dataArray[i] == "done":
			print("done with the queue!")
			sys.exit()	
		elif dataArray[i][:4] == 'file':
			fileInfo = dataArray[i].split(": ")
			dlInfo = dataArray[i+1].split(": ")
			compileInfo = dataArray[i+2].split(": ")
			exeInfo = dataArray[i+3].split(": ")
			DOWNLOADS[fileInfo[1].strip()] = dlInfo[1].strip()
			COMPILES[exeInfo[1].strip()] = compileInfo[1].strip()
			#print "wget %s" % (fileInfo[1])
			i = i + 3
		elif dataArray[i][:7] == "command":
			#print("found a command")
			COMMAND = dataArray[i].split(": ")[1].strip()
		elif dataArray[i][:6] == "random":
			RANDOM = dataArray[i].split(": ")[1].strip()
		else:
			print("unrecognized part in your file")
		i = i + 1
	for (k,v) in DOWNLOADS.iteritems():
		if os.path.exists(k) and os.path.isfile(k):
			pass
		else:
			os.system("wget -q %s" % v)
	for (k,v) in COMPILES.iteritems():
		if os.path.exists(k) and os.path.isfile(k):
			pass
		else:
			os.system("%s" % (v))
	os.system("%s > temp.%s " % (COMMAND,RANDOM))
	return_values =open("temp.%s"%(RANDOM)).read()
	posturl = "http://traviscj.com/job_queue/post_job.php"
#	headers= {'Content-type': 'application/x-wwwlencoded'}
	headers = {'Content-type': 'application/x-www-form-urlencoded'}

	postData = {'key': RANDOM, 'stat': return_values}
	body = urllib.urlencode(postData)
	#print "upload data: %s" % body
	response, content  = http.request(posturl, method="POST", body=body, headers=headers)
	if response:
	        print "Update Ok!"
	#	print response
	#        print content
	else:
	        print "error updating..."

	return 
	

if __name__=="__main__":
	while True:
		main()
