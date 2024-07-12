extends Control

@onready var controllist = $Controls/Label
@onready var backbutton = $Controls/back
@onready var pausemu = $MarginContainer
@onready var dungeon = $"../../"  # Ensure this path is correct
@onready var graveyard = $"../../" 
@onready var finalbosssroom = $"../../" 
@onready var pauseMenu = $"."  # Replace with your actual pause menu node
@onready var bg = $Controls/ColorRect

func _on_ready():
	# Ensure initial state: controllist is hidden, other buttons are shown
	controllist.hide()
	

	

func _on_resume_pressed():
	dungeon.pauseMenu()
	

func _on_controls_pressed():
	controllist.show()
	backbutton.show()
	bg.show()
	pausemu.hide()
	
	

func _on_quit_pressed():
	get_tree().quit()
	
func _on_back_pressed():
	controllist.hide()
	pausemu.show()
	bg.hide()
	backbutton.hide()
