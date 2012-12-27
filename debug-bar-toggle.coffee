( ( $ ) ->
	toggleCookie = ->
		name = 'toggle-no-debug-bar'
		if $.cookie name
			$.removeCookie name
		else
			$.cookie name, 1

		status = if $.cookie name then 'off' else 'on'
		setIndicator status

	setIndicator = ( status ) ->
		id = 'wp-admin-bar-debug-bar-toggle'
		toggled = $ "##{id}"
		toggled.remove?()

		indicator = $ '<li>'
		indicator.attr 'id', id
		indicator.html "Debug bar: #{status}"
		indicator.addClass 'ab-item ab-empty-item'
		$( '.ab-top-secondary' ).append indicator

	D = 68
	$ ->
		$.keyStroke D, toggleCookie, { modKeys: [ 'ctrlKey' ] }

) jQuery