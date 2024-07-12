extends Node

var main_scene_sound_volume = true

var player_node: Node = null
var inventory = Inventory.new()

var sound_holder

func set_player_reference(player):
	player_node = player

		
