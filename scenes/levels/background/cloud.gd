extends Movable


@onready var sprite_specular := $Sprite2D2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomise()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_move()


func _respawn() -> void:
	super()
	randomise()


func randomise() -> void:
	position.y = randi_range(10, 80)
	horizontal_speed = randf_range(-0.05, -0.0125)
	sprite_specular.position.y = 191.0 - 1.5 * position.y
