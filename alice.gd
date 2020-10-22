extends KinematicBody2D

var velocity = Vector2.ZERO
var life = 3
const SPEED = 80
const ACCELERATION = 50
var friction = 2000
var hasSmasher = false
var hasSword = false
var hasSkates = false
var hasWon = false

enum {
	MOVE,
	SMASH,
	ATTACK
}

var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	if hasWon and Input.is_action_just_pressed("menu"):
		get_tree().change_scene("res://Menu.tscn")
	match state:
		MOVE:
			state_move(delta)
		SMASH:
			state_smash(delta)
		ATTACK:
			state_attack(delta)

func state_move(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		$Position2D/sword.knockback_vector = input_vector
		animationTree.set("parameters/idle/blend_position", input_vector)
		animationTree.set("parameters/run/blend_position", input_vector)
		animationTree.set("parameters/smash/blend_position", input_vector)
		animationTree.set("parameters/attack/blend_position", input_vector)
		animationState.travel("run")
		velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION)

	else:
		animationState.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("smash"):
		if hasSmasher:
			state = SMASH
		
	if Input.is_action_just_pressed("attack"):
		if hasSword:
			state = ATTACK
			
#	if Input.is_action_just_pressed("cheat"):
#		hasSmasher = true
#		hasSword = true
#		hasSkates = true
#		get_tree().get_root().get_node("World").get_node("YSort/StopSign").hide_stop_sign()
	
func state_smash(delta):
	velocity = Vector2.ZERO
	animationState.travel("smash")

func smash_animation_done():
	state = MOVE
	
func state_attack(delta):
	velocity = Vector2.ZERO
	animationState.travel("attack")
	
func attack_animation_done():
	state = MOVE
	
func set_life(hit):
	life -= hit
	get_tree().get_root().get_node("World").get_node("CanvasLayer/Hearts").set_heart(life)
	
	if life < 1:
		$AudioDie.play()
		$AnimatedSprite.set_deferred("visible", true)
		$AnimatedSprite.play()
		get_tree().get_root().get_node("World").get_node("GameOverCanvas/GameOver").setGameOver(true)
		
	else:
		$AudioTakeDamage.play()

func getLife():
	return life

func addHeart():
	life += 1
	get_tree().get_root().get_node("World").get_node("CanvasLayer/Hearts").add_heart(life)

func receive_sword():
	hasSword = true
	$TakeSword.play()

func receive_smasher():
	hasSmasher = true
	$TakeSword.play()
	
func receive_skates():
	hasSkates = true
	$TakeSword.play()
	get_tree().get_root().get_node("World").get_node("YSort/StopSign").hide_stop_sign()
	
func _on_AnimatedSprite_animation_finished():
	queue_free()
	
func _on_FrictionArea_body_exited(body):
	if velocity.x > 0:
		friction = 100
	else: 
		friction = 2000
