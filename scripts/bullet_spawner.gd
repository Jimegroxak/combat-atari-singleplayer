extends Sprite2D
@export var Bullet: PackedScene

var player_id
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_id = owner.player_id


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_shot()

func handle_shot():
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var b = Bullet.instantiate()
	#b.get_node("Sprite2D").texture = bullet_texture
	b.set_collision_layer_value(owner.player_id + 2, true)
	owner.owner.add_child(b)
	b.transform = owner.global_transform
	#b.look_at(owner.target.global_position)
