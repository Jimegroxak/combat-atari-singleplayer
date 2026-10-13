extends Sprite2D

@export var player_id = 1

var speed = 30
var screen_size # Size of the game window

var can_turn = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_movement(delta)
	handle_rotation(delta)

func handle_movement(delta: float):
	var velocity = 0 # The player's movement vector
	
	if Input.is_action_pressed("move_up"):
		velocity = 1
		
	if velocity > 0:
		var real_vel = Vector2(cos(global_rotation), sin(global_rotation)).normalized() * speed
		position += real_vel * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		
func handle_rotation(delta):
	var a_vel = 0
	
	if can_turn:
		if Input.is_action_pressed("turn_left"):
			rotate(deg_to_rad(-22.5))
			can_turn = false
			get_node("RotateTimer").start()
			
		elif Input.is_action_pressed("turn_right"):
			rotate(deg_to_rad(22.5))
			can_turn = false
			get_node("RotateTimer").start()


func _on_rotate_timer_timeout() -> void:
	can_turn = true
