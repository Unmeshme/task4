extends Node


func play_sfx(p_audio_stream: AudioStream, p_volume_db: float = 0.0, p_pitch_scale: float = 1.0) ->void:
	if p_audio_stream == null:
		return
	
	var m_player: AudioStreamPlayer = AudioStreamPlayer.new()
	m_player.stream = p_audio_stream
	m_player.bus = "sfx"
	m_player.volume_db = p_volume_db
	m_player.pitch_scale = p_pitch_scale
	
	add_child(m_player)
	m_player.play()
	
	m_player.connect("finished", m_player, "queue_free")

#removing the positional_2d audio to reduce complexity

func play_bg_music(p_audio_stream: AudioStream) -> void:
	if p_audio_stream == null:
		return
	var m_player: AudioStreamPlayer = AudioStreamPlayer.new()
	m_player.stream = p_audio_stream
	m_player.bus = "background"
	
	add_child(m_player)
	m_player.play()
