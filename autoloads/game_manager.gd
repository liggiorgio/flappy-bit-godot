extends Node


@export var easy_mode := false
var scene_menu := preload("res://scenes/main.tscn")
var scene_game := preload("res://scenes/game.tscn")
var highscore : int


func _ready() -> void:
	GameManager.load_score()


func load_score() -> void:
	if not FileAccess.file_exists("user://savegame.save"):
		highscore = 0
	else:
		var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
		highscore = save_game.get_8()
		save_game.close()


func save_score() -> void:
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_game.store_8(highscore)
	save_game.close()


func goto_menu() -> void:
	get_tree().change_scene_to_packed(scene_menu)
	easy_mode = false


func goto_game() -> void:
	get_tree().change_scene_to_packed(scene_game)
