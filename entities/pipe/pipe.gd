@tool
extends Movable


@export_range(1,7) var height := 4 : set = _set_height
@export var randomize_at_startup := false
@onready var _body_top := $BodyTop
@onready var _body_bottom := $BodyBottom
@onready var _body_bottom_spec := $BodyBottomSpecular
@onready var _edge_bottom_spec := $EdgeBottomSpecular
@onready var _edge_top_spec := $EdgeTopSpecular
@onready var _score_detector := $ScoreDetector


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		super()
		if randomize_at_startup:
			_randomize_height()
		else:
			_set_height(height)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta) -> void:
	if not Engine.is_editor_hint():
		super(_delta)


func _randomize_height() -> void:
	height = randi_range(1, 7)


func _respawn() -> void:
	super()
	_randomize_height()
	_score_detector.visible = true
	_score_detector.set_deferred("monitorable", true)


func _set_height(new_height) -> void:
	height = clamp(new_height, 1, 7)
	position.y = 110.0 - float(height - 1) * 10
	if _body_top != null:
		_body_top.scale.y = 0.25 + (7 - height) * 1.25
		_body_bottom.scale.y = 0.25 + (height - 1) * 1.25
		_body_bottom_spec.position.y = 21.0 + float(height - 1) * 10
		_body_bottom_spec.scale.y = _body_bottom.scale.y
		_edge_bottom_spec.position.y = 22.0 + float(height - 1) * 15
		_edge_top_spec.position.y = 50.0 + float(height - 1) * 15

