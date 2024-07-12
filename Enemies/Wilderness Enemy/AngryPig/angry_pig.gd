extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animations = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

var startPosition
var endPosition

var isDead:bool = false

func _ready():
	startPosition = position
	endPosition = endPoint.global_position

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
	
	velocity = moveDirection.normalized()*speed

func updateAnimation():
	var animationString = "run"
	animations.play(animationString)
	if velocity.x > 0:
		animations.flip_h = true
	elif velocity.x < 0:
		animations.flip_h = false

func  _physics_process(delta):
	if isDead: return
	
	updateVelocity()
	move_and_slide()
	updateAnimation()


func _on_hurt_box_area_entered(area):
	if area == $hitBox: return
	$hitBox.set_deferred("monitorable", false)
	isDead = true
	animation_player.play("death")
	await animation_player.animation_finished
	queue_free()
