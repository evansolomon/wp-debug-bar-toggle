<?php

/*
Plugin Name: Debug Bar Toggle
Description: Toggle the Debug Bar with a keystroke between requests
Version: 1.01
Author: Evan Solomon
Author URI: http://evansolomon.me
*/

class Debug_Bar_Toggle {
	private static $instance;

	static function get_instance() {
		if ( ! self::$instance )
			self::$instance = new Debug_Bar_Toggle;

		return self::$instance;
	}

	private function __construct() {
		add_action( 'init', array( $this, 'init' ), 9 );
	}

	function init() {
		if ( ! $this->debug_bar_is_running() )
			return;

		add_action( 'wp_enqueue_scripts',    array( $this, 'enqueue_script' ) );
		add_action( 'admin_enqueue_scripts', array( $this, 'enqueue_script' ) );

		if ( isset( $_COOKIE['toggle-no-debug-bar'] ) )
			$this->remove_debug_bar();
	}

	function debug_bar_is_running() {
		global $debug_bar;

		return is_a( $debug_bar, 'Debug_Bar' );
	}

	function enqueue_script() {
		// Register dependencies
		wp_register_script( 'jquery-cookie',    plugins_url( 'jquery.cookie.js' , __FILE__ ), array( 'jquery' ), null, true );
		wp_register_script( 'jquery-keystroke', plugins_url( 'js-keystroke/min/jquery.keystroke.min.js', __FILE__ ), array( 'jquery' ), null, true );

		wp_enqueue_script(  'debug-bar-toggle', plugins_url( 'debug-bar-toggle.js', __FILE__ ), array( 'jquery-cookie', 'jquery-keystroke' ), null, true );
	}

	function remove_debug_bar() {
		global $debug_bar;

		remove_action( 'admin_bar_init', array( $debug_bar, 'init' ) );
	}
}

Debug_Bar_Toggle::get_instance();
