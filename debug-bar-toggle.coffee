( ( $ ) ->
	toggleCookie = ->
		name = 'toggle-no-debug-bar'
		if $.cookie name
			$.removeCookie name
		else
			$.cookie name, 1

	D = 68
	$ ->
		$.keyStroke D, toggleCookie, { modKeys: [ 'ctrlKey' ] }

) jQuery