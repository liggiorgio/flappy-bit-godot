extends Control


@onready var ui_audio := $ButtonClick


func _on_button_pressed() -> void:
	ui_audio.play()
