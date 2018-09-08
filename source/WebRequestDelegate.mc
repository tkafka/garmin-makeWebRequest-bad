//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.System as System;
using Toybox.Math as Math;


class WebRequestDelegate extends WatchUi.BehaviorDelegate {
	var notify;

	// Handle menu button press
	function onMenu() {
		makeRequest();
		return true;
	}

	function onSelect() {
		makeRequest();
		return true;
	}

	function makeRequest() {
        
		var settings = System.getDeviceSettings();

		var url;
		var params = {};

		Math.srand(System.getTimer());
		var r = Math.rand() % 4;

		notify.invoke("Executing\n request #" + r.toString());

		if (r == 0) {
			// "https://pwys.tmskfk.com/?minor=43&lat=49.399618&model=006-B2337-00&lon=15.579631&platform=garmin&aid=garmin-ZHZ11F1Z6XRUKCT9K8JFAEJH1&key=null&wid=garmin-ZHZ11F1Z6XRUKCT9K8JFAEJH1&format=array&email=null&provider=yr&v=12&major=0",

			url = "https://pwys.tmskfk.com/";
			params = {
				"aid" => "garmin-123",
				"wid" => "garmin-123",
				"model" => settings.partNumber,
				"lat" => "11.52".toString(),
				"lon" => "17.28".toString(),
				"provider" => "yr",
				"platform" => "garmin",
				"v" => 12, // protocolVersion
				"major" => 0,
				"minor" => 43,
				// USE_ARRAYS:
				"format" => "array"
				// USE_STRING:
				// (don't specify format)
			};
			params["key"] = null;
			params["email"] = null;
		} else if (r == 1) {
			url = "https://pwys.tmskfk.com/";
			params = {
				"aid" => "garmin-123",
				"wid" => "garmin-123",
				"model" => settings.partNumber,
				"lat" => "11.52".toString(),
				"lon" => "17.28".toString(),
				"provider" => "yr",
				"platform" => "garmin",
				"v" => 12, // protocolVersion
				"major" => 0,
				"minor" => 43,
				// USE_ARRAYS:
				"format" => "array"
				// USE_STRING:
				// (don't specify format)
			};			
		} else if (r == 2) {
			url = "https://pwys.tmskfk.com/";
			params = {
				"aid" => "garmin-123",
				"model" => settings.partNumber,
				"lat" => "11.52".toString(),
				"lon" => "17.28".toString(),
				"provider" => "yr",
				"platform" => "garmin",
				"v" => 12, // protocolVersion
				"major" => 0,
				"minor" => 43,
				// USE_ARRAYS:
				"format" => "array"
				// USE_STRING:
				// (don't specify format)
			};			
		} else {
			url = "https://ssltest.tomaskafka.com/json";
		}

		Communications.makeWebRequest(
			// "https://jsonplaceholder.typicode.com/todos/115",
			// "https://ssltest.tomaskafka.com/json",
			url,
			params,
			{
					// "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED
			},
			method(:onReceive)
		);
	}

	// Set up the callback to the view
	function initialize(handler) {
		WatchUi.BehaviorDelegate.initialize();
		notify = handler;
	}

	// Receive the data from the web request
	function onReceive(responseCode, data) {
		if (responseCode == 200) {
			notify.invoke(data);
		} else {
			notify.invoke("Failed to load\nError: " + responseCode.toString());
		}
	}
}