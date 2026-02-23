extends Control

@onready var email_input = $EmailInput
@onready var password_input = $PasswordInput
@onready var error_label = $ErrorLabel
@onready var login_button = $LoginButton
@onready var sign_up_button = $SignUpButton

func _ready():
	# Connect AuthManager signals (singleton must be autoloaded)
	AuthManager.login_success.connect(_on_login_success)
	AuthManager.login_failed.connect(_on_login_failed)
	
	# Connect button signals
	login_button.pressed.connect(_on_login_button_pressed)
	sign_up_button.pressed.connect(_on_sign_up_button_pressed)
	
	# Initialize error label
	error_label.text = ""
	error_label.visible = true

func _on_login_success():
	get_tree().change_scene_to_file("res://scene/HomeScreen.tscn")

func _on_login_failed(message):
	error_label.text = str(message)

func _on_login_button_pressed():
	var email = email_input.text.strip_edges()
	var password = password_input.text.strip_edges()
	
	if email == "" or password == "":
		error_label.text = "Please enter email and password"
		return
	
	error_label.text = ""
	AuthManager.login(email, password)

func _on_sign_up_button_pressed():
	get_tree().change_scene_to_file("res://scene/SignupScreen.tscn")
