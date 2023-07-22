extends CanvasLayer

signal transition_finished

func transition_dissolve() -> void:
	$AnimationPlayer.play("dissolve", -1, 0.5)
	
	await $AnimationPlayer.animation_finished
	emit_signal("transition_finished")
	

func transition_dissolve_back() -> void:
	$AnimationPlayer.play_backwards('dissolve')
