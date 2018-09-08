# The problem: 

This widget runs OK in simulator, but all requests fail with -400 on real device when the app is downloaded from Garmin Store.

# The solution:

`makeWebRequest` `params` *cannot* have NULLs as values. When this happens (`params = { "email" => null }`), it works OK in simulator, works OK when built for device, and fails with -400 code when released in a real app. Sigh.

# Some keywords for unlucky people who might find this bug:

Garmin, INVALID_HTTP_BODY_IN_NETWORK_RESPONSE = -400