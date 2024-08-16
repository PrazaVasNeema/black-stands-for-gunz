extends GunKiso


@export var lazer_max_energy : float = 100
@export var lazer_depl_speed : float = 20
@export var lazer_rec_speed : float = 30
@export var lazer_start_rec_delay : float = 1
@export var _laser_beam_buhin : LaserBeamBuhin


func lock_n_load(this_gun_num : int):
    super(this_gun_num)
    _laser_beam_buhin.lock_n_load()


func fuc_em_start():
    super()
    _laser_beam_buhin.turn_on_beam()


func fuc_em_stop():
    super()
    _laser_beam_buhin.turn_off_beam()