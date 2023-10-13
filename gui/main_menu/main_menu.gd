extends Control


@onready var ui_audio := $ButtonClick


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/CenterContainer/PlayButton.pressed.connect($Fade.fade_out)
	$HBoxContainer/CenterContainer/PlayButton.pressed.connect($Timer.start)
	$HBoxContainer/CenterContainer2/EasyPlayButton.pressed.connect($Fade.fade_out)
	$HBoxContainer/CenterContainer2/EasyPlayButton.pressed.connect($Timer2.start)
	$Timer.timeout.connect(_on_timer_timeout)
	$Timer2.timeout.connect(_on_timer2_timeout)
	$Fade.fade_in()


func _on_timer_timeout() -> void:
	GameManager.goto_game()


func _on_timer2_timeout() -> void:
	GameManager.easy_mode = true
	GameManager.goto_game()


func _on_button_pressed() -> void:
	ui_audio.play()
