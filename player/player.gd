class_name Player extends CharacterBody2D

signal healthChanged

@export var speed: int = 50
@onready var animations = $AnimatedSprite2D
@onready var effects = $effects
@onready var hurtBox = $hurtBox
@onready var hurtTimer = $hurtTimer
@onready var attackPlayer = $AnimationPlayer
@onready var weapon = $weapon

@export var inventory: Inventory

var isMoving: bool = false
var lastDirection: Vector2 = Vector2(0, 1)

@export var maxHealth = 3
@export var currentHealth: int = maxHealth

@export var knockbackPower: int = 500

var isHurt: bool = false
var isAttacking: bool = false

func _ready():
	inventory.use_item.connect(use_item)
	effects.play("RESET")
	Global.set_player_reference(self)
	weapon.disable()

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
	if Input.is_action_just_pressed("attack"):
		attackAnimation()
		
func attackAnimation():
	if lastDirection.x < 0:
		attackPlayer.play("attackLeft")
	elif lastDirection.x > 0:
		attackPlayer.play("attackRight")
	elif lastDirection.y > 0:
		attackPlayer.play("attackFront")
	elif lastDirection.y < 0:
		attackPlayer.play("attackBack")
		
	weapon.enable()
	await attackPlayer.animation_finished
	weapon.disable()
	
func updateAnimation():
	if velocity.length() == 0:
		if lastDirection.x < 0:
			animations.play("idleSide")
			$AnimatedSprite2D.scale.x = -1
		elif lastDirection.x > 0:
			animations.play("idleSide")
			$AnimatedSprite2D.scale.x = 1
		elif lastDirection.y > 0:
			animations.play("idleFront")
		elif lastDirection.y < 0:
			animations.play("idleBack")
	else:
		var direction
		if velocity.x < 0:
			direction = "Side"
			$AnimatedSprite2D.scale.x = -1
		elif velocity.x > 0:
			direction = "Side"
			$AnimatedSprite2D.scale.x = 1
		elif velocity.y > 0:
			direction = "Front"
		elif velocity.y < 0:
			direction = "Back"
		
		animations.play("move" + direction)
		lastDirection = velocity.normalized()
		
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

func _physics_process(delta):
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "hitBox":
				hurtByEnemy(area)
	
func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth <= 0:
		currentHealth = maxHealth
	
		var current_scene = get_tree().current_scene
		get_tree().reload_current_scene()
		
		
	healthChanged.emit(currentHealth)
	isHurt = true
	knockback(area.get_parent().velocity)
	effects.play("hurtBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false
	
	

func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized()*knockbackPower
	velocity = knockbackDirection
	move_and_slide()

func _on_hurt_box_area_exited(area):
	pass

func increase_health(amount: int) -> void:
	currentHealth += amount
	currentHealth = min(maxHealth, currentHealth)
	
	healthChanged.emit(currentHealth)

func use_item(item: InventoryItem) -> void:
	item.use(self)
