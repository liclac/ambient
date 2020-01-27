function ambient_get_icomera_endpoint
	set url https://www.ombord.info/api/jsonp/$argv/

	if test (uname) = "Darwin"
		curl -s $url | tail -c +2 | ghead -c -3
	else
		curl -s $url | tail -c +2 | head -c -3
	end
end