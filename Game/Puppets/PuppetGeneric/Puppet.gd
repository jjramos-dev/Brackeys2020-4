extends RigidBody2D


export var max_energy=100

export var isTouchable=true
export var rechargeRate=1

export var speed=1

var energy=0

var direction=Vector2(1,0)

var recharging=false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	
	if recharging:
		recharge(delta)	
	else:
		apply_charge(energy)
		discharge(delta)
	update_bar(energy)

func update_bar(en):
	$TextureProgress.value=100*energy/max_energy
	
func discharge(en):
	energy-=en
	if energy<0:
		energy=0

func apply_charge(en):
	if en>0:
		apply_impulse(Vector2(0,0),direction*speed)
	


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
