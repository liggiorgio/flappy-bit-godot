extends Node


@onready var score_table := $Scoretable
@onready var score_label := $Scoretable/Score
@onready var final_score_label := $GameOver/ScorePanel/MarginContainer/VBoxContainer/HBoxContainer/CurrScoreLabel
@onready var best_score_label := $GameOver/ScorePanel/MarginContainer/VBoxContainer/HBoxContainer2/BestScoreLabel
var score := 0
var is_game_over := false
var is_high_score := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Setup game signals
	$LevelGame/Bird.pipe_scored.connect(add_score)
	$LevelGame/Bird.bird_collided.connect(game_over)
	# Setup GUI signals
	$GameOverTimer.timeout.connect(show_game_over)
	$RestartTimer.timeout.connect(GameManager.goto_game)
	$QuitTimer.timeout.connect(GameManager.goto_menu)
	$GameOver/%RestartButton.pressed.connect($RestartTimer.start)
	$GameOver/%RestartButton.pressed.connect($Fade.fade_out)
	$GameOver/%ExitButton.pressed.connect($QuitTimer.start)
	$GameOver/%ExitButton.pressed.connect($Fade.fade_out)
	$GameOver.visible = false
	#$GameOver.set_process(false)
	# Pause the game
	$Fade.fade_in()
	get_tree().paused = true


func _unhandled_input(_event: InputEvent) -> void:
	# Start the game at screen tap
	if Input.is_action_just_pressed("tap") and get_tree().paused:
		get_tree().paused = false
		$Tutorial.queue_free()


func add_score() -> void:
	score = score + 1
	score_label.text = str(score)


func game_over() -> void:
	if not is_game_over:
		is_game_over = true
		score_table.visible = false
		final_score_label.text = str(score)
		if score > GameManager.highscore:
			GameManager.highscore = score
			GameManager.save_score()
			is_high_score = true
		best_score_label.text = str(GameManager.highscore)
		$FlashAnimator.play("flash")
		$GameOverTimer.start()


func show_game_over() -> void:
	$GameOver.visible = true
	$GameOver.set_process(true)
	if is_high_score:
		$GameOver/NewBest.play("new_best")
