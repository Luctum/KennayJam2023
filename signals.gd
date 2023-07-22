extends Node

signal player_entered(node_entered);

func emit_player_entered(node_entered):
	player_entered.emit(node_entered)
