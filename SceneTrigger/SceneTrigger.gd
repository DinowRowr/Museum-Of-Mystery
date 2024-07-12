class_name SceneTrigger extends Area2D

@export var connected_scene: String

var scene_file = "res://assets/Wilderness/dungeon/"
var cutscene_scene_file = "res://assets/Merchant_Cutscene/"
var boss1_scene_file = "res://assets/boss1_CS/"
var museum1_scene_file = "res://assets/Wilderness/"
var graveyard_scene_file = "res://assets/Wilderness/graveyard/"
var boss2_scene_file = "res://assets/graveyardCS/"
var main3_scene_file = "res://assets/Wilderness/"
var boss3_scene_file = "res://assets/Wilderness/final_boss_room/"
var final_scene_file = "res://assets/final/"
var menu_scene_file = "res://scenes/UI/"


func _on_body_entered(body):
	
	var full_path = scene_file + connected_scene + ".tscn"
	var cutscene_full_path = cutscene_scene_file + connected_scene + ".tscn"
	var boss1_full_path = boss1_scene_file + connected_scene + ".tscn"
	var museum1_full_path = museum1_scene_file + connected_scene + ".tscn"
	var graveyard_full_path = graveyard_scene_file + connected_scene + ".tscn"
	var boss2_full_path = boss2_scene_file + connected_scene + ".tscn"
	var main3_full_path = main3_scene_file + connected_scene + ".tscn"
	var boss3_full_path = boss3_scene_file + connected_scene + ".tscn"
	var final_full_path = final_scene_file + connected_scene + ".tscn"
	var menu_full_path = menu_scene_file + connected_scene + ".tscn"
	
	var scene_tree = get_tree()
	
	scene_tree.change_scene_to_file(full_path)
	scene_tree.change_scene_to_file(cutscene_full_path)
	scene_tree.change_scene_to_file(boss1_full_path)
	scene_tree.change_scene_to_file(museum1_full_path)
	scene_tree.change_scene_to_file(graveyard_full_path)
	scene_tree.change_scene_to_file(boss2_full_path)
	scene_tree.change_scene_to_file(main3_full_path)
	scene_tree.change_scene_to_file(boss3_full_path)
	scene_tree.change_scene_to_file(final_full_path)
	scene_tree.change_scene_to_file(menu_full_path)

