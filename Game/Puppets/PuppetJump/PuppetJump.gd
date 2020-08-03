extends Puppet

var on_jump := false

func _ready():
	recharge_rate = 4
	discharge_rate = 8

func _on_discharge():
	if max_energy_charged > 0 and not on_jump:
		on_jump = true
		$Timer.start(0.4)
	"""var pre_vel : Vector2
	if max_energy_charged > 0:
		print(max_energy_charged)
		jump(max_energy_charged)
		max_energy_charged = 0
	pre_vel = velocity
	velocity = move_and_slide(velocity,Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider is Player:
			print("I collided with ", collision.collider.name)"""
	

func jump_3() -> void:
	position.y -= max_energy_charged

"""func jump(jump_mult : int) -> void:
	jump_height = jump_height_step * jump_mult
	gravity = (2 * jump_height) / pow(time_jump_apex, 2)
	jump_force = gravity * time_jump_apex
	velocity.y = -jump_force
	
func jump2(jump_mult : int) -> void:
	pass"""

func apply_charge():
	if energy > max_energy_charged:
		max_energy_charged = energy
	if on_jump:
		jump_3()
	else:
		velocity = move_and_slide(velocity,Vector2.UP)

func _on_Timer_timeout() -> void:
	on_jump = false
	max_energy_charged = 0
