extends CharacterBody2D

const PLAYER_INITIAL_SPEED = 10
const PLAYER_MAX_SPEED = 600
var player_speed = PLAYER_INITIAL_SPEED
var mouse_position = null
var fuel = 150
var player_max_fuel = 150
var player_fuel_loss_rate = 0.015
var animation_played = false
var candy_list = []

signal no_fuel_left;
 

# Called when the node enters the scene tree for the first time.
func _ready():
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	Signals.player_entered.connect(_on_candy_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$DebugLabel.text = str(fuel)
	if fuel <= 0:
		emit_signal("no_fuel_left")
		


func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position).normalized()
	velocity = direction * player_speed
	if is_cursor_away_from_player && Input.is_action_pressed("forward") && fuel > 0:
		fuel -= player_speed * player_fuel_loss_rate * delta
		move_player_while_looking_at_mouse()
		if player_speed < PLAYER_MAX_SPEED && player_speed:
			progressive_ship_startup(5, 1)
			if !animation_played:
				$AnimationPlayer.play("start")
				fuel -= 5
				animation_played = true
			$Sounds/Wind.play()
			
	else:
		if player_speed > PLAYER_INITIAL_SPEED:
			move_player_while_looking_at_mouse()
			progressive_ship_startup(-5, 1)
			animation_played = false
			$Sounds/Wind.stop()


func is_cursor_away_from_player():
	return position.x + 5 <  mouse_position.x || position.x - 5 > mouse_position.x 


func move_player_while_looking_at_mouse():
	move_and_slide()
	look_at(mouse_position)


func progressive_ship_startup(speed_increase, timer):
	player_speed += speed_increase
	await get_tree().create_timer(timer).timeout
	
func _on_candy_entered(candy):
	var newcandy = candy.duplicate()
	$Sounds/Coin.play(0.0)
	candy_list.append(newcandy)
	candy.queue_free()
