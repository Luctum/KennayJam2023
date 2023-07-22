extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_no_fuel_left():
	#Reset pos is played by the animation
	SceneTransition.transition_dissolve()
	await SceneTransition.transition_finished
	reset_played_pos_fade_in()
	SceneTransition.transition_dissolve_back()
	
func reset_played_pos_fade_in():
	$Player.position.x = 377
	$Player.position.y = 6
	$Player.rotation_degrees = 158
	$Player.fuel = $Player.player_max_fuel
	$Player.player_speed = $Player.PLAYER_INITIAL_SPEED
