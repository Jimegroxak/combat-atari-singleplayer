extends Sprite2D
@export var Bullet: PackedScene

var player_id

var can_shoot = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_id = owner.player_id

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_shot()

func handle_shot():
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
		can_shoot = false
		get_node("ShotTimer").start()

func shoot():
	if player_id == 1:
		var b = Bullet.instantiate()
		b.tank = owner
		#b.get_node("Sprite2D").texture = bullet_texture
		b.set_collision_layer_value(owner.player_id + 1, true)
		owner.owner.add_child(b)
		b.transform = owner.global_transform

func _on_shot_timer_timeout() -> void:
	can_shoot = true
