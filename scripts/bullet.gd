extends Area2D

var speed = 1040
var screen_size
var tank
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var real_vel = Vector2(cos(global_rotation), sin(global_rotation)).normalized() * speed
	position += real_vel * delta
	if position.x < 0 or position.x > screen_size.x or position.y < 64 or position.y > screen_size.y:
		queue_free()
	global_rotation = tank.transform.get_rotation()
