default: minify

# top level target
minify: clean
	@echo 'Minifying existing js ...'
	grunt
	@echo 'Cleaning up ...'
	rm -f www/js/*.concat.js
	@echo 'Finished!'

clean:
	rm -f www/js/*.concat.js
	rm -f www/js/*.min.js