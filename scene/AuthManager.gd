extends Node

var user_id := ""
var id_token := ""

signal login_success
signal login_failed(error)
const Keys = preload("res://scene/api_keys.gd")

func login(email: String, password: String):
	var url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + Keys.FIREBASE_KEY

	var body = {
		"email": email,
		"password": password,
		"returnSecureToken": true
	}

	var http := HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_response)
	http.request(
		url,
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		JSON.stringify(body)
	)

func _on_response(_r, code, _h, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	if code == 200 and data != null:
		user_id = data["localId"]
		id_token = data["idToken"]
		login_success.emit()
	else:
		var message = "Login failed"
		if data and data.has("error"):
			message = data["error"]["message"]
		login_failed.emit(message)
	
	# Clean up the HTTPRequest node
	for child in get_children():
		if child is HTTPRequest:
			child.queue_free()
