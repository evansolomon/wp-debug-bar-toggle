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
		statusClass = 'debug-bar-toggle-status'
		# Use the debug bar item if it's there
		$el = $( '#wp-admin-bar-debug-bar > div:first' )
		if $el.length
			$el.addClass statusClass
			return $el.html "Debug: #{status}" if $el.length

		# Otherwise make a admin bar item to show the status
		id = 'wp-admin-bar-debug-bar-toggle'
		toggled = $ "##{id}"
		toggled.remove?()

		indicator = $ '<li>'
		indicator.attr 'id', id

		content = $ '<div>'
		content.addClass "ab-item ab-empty-item #{statusClass}"
		content.html "Debug bar: #{status}"
		$( '.ab-top-secondary' ).append indicator.append( content )

	D = 68
	$ ->
		$.keyStroke D, toggleCookie, { modKeys: [ 'ctrlKey' ] }

) jQuery