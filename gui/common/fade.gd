extends Control


@onready var _animator := $Animator


func fade_in() -> void:
	_animator.play("fade_in")


func fade_out() -> void:
	_animator.play("fade_out")
