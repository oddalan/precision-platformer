extends CharacterBody2D

@onready var coyote_time = %"Coyote Time"
@onready var jump_buffer = %"Jump Buffer"

@onready var cc_top_left  = %"Head Left"
@onready var cc_top_right = %"Head Right"

@onready var cc_base_left  = %"Base Left"
@onready var cc_base_right = %"Base Right"

const SPEED = 4000

@export_category("Curves")
@export var acceleration_curve: Curve

@export var curve_time: float = 100.0

@export var gravity: float = 250.0

@export var jump_height: float = 31.0

var left_started: float = 0.0
var right_started: float = 0.0

func _ready() -> void:
	Engine.time_scale = 1.0
	
var old_velocity: float = 0.0

func _physics_process(delta: float) -> void:
	var dir = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_pressed("ui_left"):
		if Input.is_action_just_pressed("ui_left"):
			left_started = Time.get_ticks_msec() / curve_time
		else:
			var time_now = Time.get_ticks_msec() / curve_time
			
			dir *= acceleration_curve.sample(time_now - left_started)
	if Input.is_action_just_released("ui_left"):
		left_started = 0
	
	if Input.is_action_pressed("ui_right"):
		if Input.is_action_just_pressed("ui_right"):
			right_started = Time.get_ticks_msec() / curve_time
		else:
			var time_now = Time.get_ticks_msec() / curve_time
			
			dir *= acceleration_curve.sample(time_now - right_started)
	if Input.is_action_just_released("ui_right"):
		left_started = 0
	
	velocity.x = dir * SPEED * delta
	
	if cc_top_left.get_node("Tip").is_colliding() and is_on_ceiling_only():
		if not cc_top_left.get_node("Center").is_colliding():
			
			
			while is_on_ceiling():
				move_and_slide()
				position.x += 1
				
			velocity.y = old_velocity
	
	if cc_top_right.get_node("Tip").is_colliding() and is_on_ceiling_only():
		if not cc_top_right.get_node("Center").is_colliding():
			
			
			while is_on_ceiling():
				move_and_slide()
				position.x -= 1
				
			velocity.y = old_velocity
	
	if velocity != Vector2(0, 0):
		old_velocity = velocity.y
		move_and_slide()
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -sqrt(2 * gravity * jump_height)
	
	
	#if %"Base Left".get_node("Tip").is_colliding():
		#if not %"Base Left".get_node("Center").is_colliding():
			#position += Vector2(-2, -2)
		#
	#if %"Base Right".get_node("Tip").is_colliding():
		#if not %"Base Right".get_node("Center").is_colliding():
			#position += Vector2(2, -2)
