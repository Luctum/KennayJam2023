extends Control

@export var current_fuel = 0.0
@export var max_fuel = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.max_value = max_fuel
	$ProgressBar.value = current_fuel
	$ProgressBar/HBoxContainer/CurrentFuel.text = str(floor(current_fuel))
	$ProgressBar/HBoxContainer/MaxFuel.text = "/" + str(floor(max_fuel))

func set_current_fuel(fuel):
	current_fuel = fuel
