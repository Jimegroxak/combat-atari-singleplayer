extends Sprite2D

@export var player_id = 2
@export var other_tank: Node2D

var speed = 55 # should move across screen in about 19 seconds
var real_vel
var screen_size # Size of the game window
var d

var enemy_bullet

var rng = RandomNumberGenerator.new() #used for movement for now

var is_dodging = false
var can_turn = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	d = delta
	#handle_movement(delta)
	#handle_rotation(delta)
	if is_dodging and enemy_bullet != null:
		dodge_bullet(enemy_bullet, delta)

func handle_movement(delta: float):
	var velocity = 0 # The player's movement vector
	
	var v = rng.randi_range(0,5) #random chance of moving forward, should move most of the time
	if v in range(0,4):
		velocity = 1
		
	if velocity > 0:
		real_vel = Vector2(cos(global_rotation), sin(global_rotation)).normalized() * speed
		position += real_vel * delta
		if position.x < 40 or position.x > screen_size.x - 40 or position.y < 100 or position.y > screen_size.y - 40:
			position -= 20*real_vel * delta
		position = position.clamp(Vector2(40,100), screen_size-Vector2(40,40))
		
		
func handle_rotation(delta):
	if can_turn:
		if not is_dodging:
			var r = rng.randi_range(0,6) #random chance of turning, then in a random direction
			if r == 0:
				var turn_dir = rng.randi_range(0,1)
				if turn_dir == 1:
					rotate(deg_to_rad(-22.5))
					can_turn = false
					get_node("RotateTimer").start()
					
				else:
					rotate(deg_to_rad(22.5))
					can_turn = false
					get_node("RotateTimer").start()
		else:
			rotate(deg_to_rad(-22.5))
			can_turn = false
			get_node("RotateTimer").start()
			
			

func dodge_bullet(bullet: Area2D, delta: float):
	var target_rotation = bullet.transform.get_rotation() + PI/2
	handle_rotation(delta)

func _on_rotate_timer_timeout() -> void:
	can_turn = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not area.is_in_group("bullet"):
		position -= 20*real_vel * d
		position = position.clamp(Vector2(40,100), screen_size-Vector2(40,40))


func _on_bullet_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		is_dodging = true
		enemy_bullet = area
