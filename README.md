# uottahack-2018-server
Welcome to our uOttaHack Winter 2018 server-side project!

### About
This is very short documentation explaining how this (side-) project works. This is basically the server-side of the [uOttHack-2018 Android application](https://github.com/thedrummeraki/uottahack-2018) that allows ticket management. This server-side, running Ruby on Rails 5, returns JSON to the client. Below are listed the possible endpoints.

### JSON API endpoints
**Base URL**:
```
https://uottahack-2018.herokuapp.com
```

**JSON Error responses**
You will get a JSON error body looking like the following:
```json
{
	"success": false,
	"message": "An error message",
	"reason": "A simpler error message (if necessary)"
}
```

If there are no `message` or `reason` JSON fields but the `success` field is `false`, then the attempted action was __not__ successful. You should try again or check your parameters.

**HTTP endpoints**
Description: Get a new API token necessary for all requests. No request body/parameters needed.
```
POST /api/new/token
Request: {}
Response: {
	success: bool, 
	auth_token: string
}
```
Description: Creates a new ticket with a provided code at the specified location. No particular format for the code is required.
```
GET /api/tickets/new
Request: {token: string, location_id: integer, ticket_code: string}
Response: {
	success: bool, 
	message: string,
	reason: string,
	errors: [],
	ticket:  {
		id: int, 
		ticket_code: string, 
		ticket_count: string, 
		in_use: bool, 
		created_at: string, 
		updated_at: string
	}
}
```
Description: Get the currently serving ticket at the specified location.
```
GET /api/tickets/current
Request: {token: string, location_id: integer}
Response: {
	success: bool,
	ticket:  {
		id: int, 
		ticket_code: string, 
		ticket_count: string, 
		in_use: bool, 
		created_at: string, 
		updated_at: string
	}
}
```
Description: Get the average wait time at the specified location.
```
GET /api/tickets/wait-time
Request: {token: string, location_id: integer}
Response: {
	success: bool, 
	wait_time: {
		hours: int, 
		mins: int, 
		approximation: bool
	}
}
```
Description: Gets the next time in line and sets it as the serving ticket, at the specified location.
```
POST /api/tickets/next
Request: {token: string, location_id: integer}
Response: {
	success: bool, 
	message: string, 
	reason: string, 
	errors: []
}
```
Description: Sets the specified ticket as not in service anymore.
```
POST /api/tickets/cancel
Request: {token: string, location_id: integer, }
Response: {
	success: bool, 
	message: string, 
	ticket_code: string, 
	reason: string
}
```
