extends Node


@warning_ignore_start("unused_signal")

signal level_start_request
signal level_end_request
signal level_started
signal level_ended
signal level_restarted

signal weapon_fired_request
signal weapon_fired (weapon: Weapon)
signal weapon_angle_changed (new_angle: float)
signal weapon_power_changed (new_power: float)
