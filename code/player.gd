extends CharacterBody2D

signal hit
const SPEED = 300.0
var screen_size


# Get the gravity from the project settings to be synced with RigidBody nodes.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _on_body_entered(body):
	hide()
	hit.emit()
	$Head.set_deferred("disabled", true)
	$Body.set_deferred("disabled", true)
	$RightHand.set_deferred("disabled", true)
	$LeftHand.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$Head.disabled = false
	$Body.disabled = false
	$LeftHand.disabled = false
	$RightHand.disabled = false

func _process(delta):
	var velocity:Vector2 = get_movenet()
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	move_and_collide(velocity * delta)
	position = position.clamp(Vector2.ZERO, screen_size)
	animation_selector(velocity)


func animation_selector(velocity: Vector2):
	var old_animation:StringName = $PlayerSprite.get_animation()
	var animation: StringName
	if velocity.x == 0 && velocity.y == 0:
		animation = "idle"
		$PlayerSprite.flip_v = false
	elif velocity.x != 0:
		animation = "run"
		$PlayerSprite.flip_v = false
		$PlayerSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		animation = "run"
		$PlayerSprite.flip_v = false
	if animation != old_animation:
		$PlayerSprite.stop()
		$PlayerSprite.animation = animation
		$PlayerSprite.play(animation)

func get_movenet() -> Vector2:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	return velocity
