extends Area2D


signal bird_collided
signal pipe_scored

@export var max_velocity := 0.0
@export var grav := 0.0
@export var pulse := 0.0
@onready var sprite := $AnimatedSprite2D
@onready var sprite_specular := $AnimatedSprite2DSpecular
@onready var audio_flap := $AudioFlap
@onready var audio_score := $AudioScore
@onready var audio_death := $AudioDeath
@onready var _hor_velocity : float = get_parent().get_node("Ground").horizontal_speed
var _ver_velocity := 0.0
var _alive := true
var _boundary_y := 116


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flap()
	sprite_specular.visible = true


func _unhandled_input(_event: InputEvent) -> void:
	if _alive and Input.is_action_just_pressed("tap"):
		flap()


func flap() -> void:
	# Apply tap velocity
	_ver_velocity = pulse
	# Animate
	sprite.stop()
	sprite.play("flap")
	sprite_specular.stop()
	sprite_specular.play("flap")
	audio_flap.play()
	get_viewport().set_input_as_handled()


func _physics_process(_delta: float) -> void:
	# Integrate - Custom physics
	_ver_velocity += grav
	position.y += _ver_velocity
	# Clamp quantities
	_ver_velocity = clampf(_ver_velocity, -max_velocity, max_velocity)
	position.y = clampf(position.y, 0.0, _boundary_y)
	sprite_specular.position.y = 191.0 - 1.5 * position.y
	# Procedurally animate
	if _alive:
		var _target_dir := atan2(_ver_velocity, -5 * _hor_velocity)
		sprite.rotation = lerp_angle(sprite.rotation, _target_dir, 0.25)
	else:
		sprite.rotation = lerp_angle(sprite.rotation, 0.5 * PI, 0.125)
	sprite_specular.rotation = -sprite.rotation / 2

func _on_ground_entered(area: Area2D) -> void:
	if area.get_name() == "ScoreDetector" and _alive:
		area.visible = false
		area.set_deferred("monitorable", false)
		audio_score.play()
		emit_signal("pipe_scored")
	else:
		emit_signal("bird_collided")


func _on_bird_collided() -> void:
	if _alive:
		audio_death.play()
	if _alive or (_ver_velocity > -pulse / 2 and position.y > 110.0):
		_ver_velocity = pulse / 2
	_alive = false
