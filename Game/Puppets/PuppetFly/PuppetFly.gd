extends Puppet

func _ready() -> void:
	discharge_rate = 3

func apply_charge():
	var mult := 1.5
	if energy > 0:
		velocity.y = 0
	if energy < 1:
		mult = 1.0
	if energy < 0.5:
		mult = 0
	"""if energy > 0:
		direction = 1
		velocity.y = 0
	elif direction > 0.01:
		direction *= stop_speed
	else:
		direction = 0"""
	velocity.x = speed * mult * direction
	velocity = move_and_slide(velocity,Vector2.UP)

func _physics_process(delta):

	#._physics_process(delta)	
	
#	if recharging:
#		state=STATE.RECHARGING
#	elif energy>0:
#		state=STATE.DISCHARGING
#	else:
#		state=STATE.IDLE
	#Esto debería estar en el genérico no?
	match state:
		STATE.IDLE:
			$AnimationPlayer.play("idle")
			
		STATE.DISCHARGING:
			#apply_charge()
			$AnimationPlayer.play("discharging")
			
		STATE.RECHARGING:
			$AnimationPlayer.play("recharging")
			#recharge(delta*recharge_rate)
