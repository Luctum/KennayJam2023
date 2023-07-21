extends CharacterBody2D

var player_speed = 200
var mouse_position = null





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position).normalized()
	print_debug()
	velocity = direction * player_speed
	if position.x + 5 <  mouse_position.x || position.x -5 > mouse_position.x:
		move_and_slide()
		look_at(mouse_position)
