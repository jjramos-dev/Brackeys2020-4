extends Puppet

enum STATE {IDLE, WALKING, RECHARGING}
var state=STATE.IDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	if recharging:
		state=STATE.RECHARGING
	elif energy>0:
		state=STATE.WALKING
	else:
		state=STATE.IDLE
	
	match state:
		STATE.IDLE:
			$AnimationPlayer.play("idle")
		STATE.WALKING:

			apply_charge(energy,delta)
			$AnimationPlayer.play("walking")
			
		STATE.RECHARGING:
			$AnimationPlayer.play("recharging")
			recharge(delta*recharge_rate)	

