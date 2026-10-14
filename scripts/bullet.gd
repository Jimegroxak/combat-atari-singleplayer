extends Area2D

var speed = 1040
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var real_vel = Vector2(cos(global_rotation), sin(global_rotation)).normalized() * speed
	position += real_vel * delta
