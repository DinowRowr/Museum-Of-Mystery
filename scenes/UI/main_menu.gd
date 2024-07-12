class_name MainMenu
extends Control

@onready var start = $MarginContainer/HBoxContainer/VBoxContainer/Start as Button
@onready var exit = $MarginContainer/HBoxContainer/VBoxContainer/Exit as Button
@onready var start_level = preload("res://assets/Intro_Cutscene/intro_1.tscn") as PackedScene

func _ready():
	start.button_down.connect(on_start_pressed)
	exit.button_down.connect(on_exit_pressed)
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed() -> void:
	get_tree().quit()
