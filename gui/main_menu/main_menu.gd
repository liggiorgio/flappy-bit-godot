extends Control


@onready var ui_audio := $ButtonClick


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/PlayButton.pressed.connect($Fade.fade_out)
	$CenterContainer/PlayButton.pressed.connect($Timer.start)
	$Timer.timeout.connect(_on_timer_timeout)
	$Fade.fade_in()


func _on_timer_timeout() -> void:
	GameManager.goto_game()


func _on_button_pressed() -> void:
	ui_audio.play()
