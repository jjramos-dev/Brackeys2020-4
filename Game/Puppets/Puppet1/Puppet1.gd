extends Puppet


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
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
			$AnimationPlayer.play("walking")
			
		STATE.RECHARGING:
			$AnimationPlayer.play("recharging")
			#recharge(delta*recharge_rate)

