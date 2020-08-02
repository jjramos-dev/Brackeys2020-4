extends RigidBody2D


export var max_energy=10

export var isTouchable=true
export var rechargeRate=1

export var speed=1

var in_the_air=false
var energy=0

var direction=Vector2(1,0)

var recharging=false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgress.max_value=max_energy

func _physics_process(delta):
	
	
	if recharging:
		recharge(delta)	

	else:
		apply_charge(energy)
		discharge(delta)
		
	if energy>0:	
		$TextureProgress.visible=true
		update_bar(energy)
	else:
		$TextureProgress.visible=false
		

func update_bar(en):
	$TextureProgress.value=en  # /(1.0*max_energy)  # x100

	
func discharge(en):
	energy-=en
	if energy<0:
		energy=0

func apply_charge(en):
	if en>0:
		if not in_the_air:
			# The force is applied near the bottom of the box
			apply_impulse(Vector2(0,20),direction*speed)
	


func recharge(amount):
	energy=energy+amount
	
	
# If is touchable, we can put energy in the Puppet:
func _on_Puppet_input_event(viewport, event, shape_idx):
	if isTouchable:
		if event is InputEventMouseButton:
			if event.pressed:
				recharging=true
			elif not event.pressed:
				recharging=false


func _on_Puppet_body_shape_exited(body_id, body, body_shape, local_shape):
	in_the_air=true
	

	


func _on_Puppet_body_shape_entered(body_id, body, body_shape, local_shape):
	in_the_air=false
