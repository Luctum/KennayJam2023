extends Node2D

signal player_back_to_spawn;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UserInterface.position = $Player.position
	$UserInterface.position.y += 75
	$UserInterface.current_fuel = $Player.fuel
	$UserInterface.max_fuel = $Player.player_max_fuel
	$Control.position = $Player.position
	$Control.position.x -= 600
	$Control.position.y -= 350
	
	$Control.compteur_bonbon_value = $Player.candy_list.size()


func _on_player_no_fuel_left():
	#Reset pos is played by the animation
	SceneTransition.transition_dissolve()
	await SceneTransition.transition_finished
	reset_played_pos_fade_in()
	SceneTransition.transition_dissolve_back()
 
 
func reset_played_pos_fade_in(replacecandies=true):
	$Player.position.x = 377
	$Player.position.y = 6
	$Player.rotation_degrees = 158
	$Player.fuel = $Player.player_max_fuel
	$Player.player_speed = $Player.PLAYER_INITIAL_SPEED
	if $Player.candy_list.size() > 0:
		$Sounds/Coin.play()
	if replacecandies :
		for candy in $Player.candy_list:
			add_child(candy)
	$Player.candy_list.clear()


func _on_area_2d_area_entered(area):
	SceneTransition.transition_dissolve()
	await SceneTransition.transition_finished
	$Player.player_max_fuel += $Player.candy_list.size() * 50
	reset_played_pos_fade_in(false)
	SceneTransition.transition_dissolve_back()


func _on_king_candy_candy_touched():
	SceneTransition.transition_dissolve()
	await SceneTransition.transition_finished
	$Sounds/Music.stop()
	$Sounds/Coin.play(0.0)
	$Sounds/Victory.play(0.0)
	$FonduNoir.visible = true
	$Player.player_can_move = false
	$FonduNoir.position = $Player.position
	SceneTransition.transition_dissolve_back()

