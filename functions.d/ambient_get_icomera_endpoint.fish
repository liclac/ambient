function ambient_get_icomera_endpoint
	set url https://www.ombord.info/api/jsonp/$argv/

	curl -s $url | tail -c +2 | ghead -c -3
end