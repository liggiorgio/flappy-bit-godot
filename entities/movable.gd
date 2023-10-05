class_name Movable
extends Node2D


@export var horizontal_speed := 0.0
@export var horizontal_limit := 0.0
@export var horizontal_shift := 0.0
var _game_over := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var _bird = get_tree().root.find_child("Bird", true, false)
	if _bird != null:
		_bird.bird_collided.connect(_halt)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if not _game_over:
		_move()


func _move() -> void:
	position.x += horizontal_speed
	if position.x < horizontal_limit:
		_respawn()


func _respawn() -> void:
	position.x += horizontal_shift


func _halt() -> void:
	_game_over = true
