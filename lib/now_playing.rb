module NowPlaying
  NOW_PLAYING_ENDPOINT = 'http://thelot.airtime.pro/api/live-info-v2'.freeze
  YOUTUBE_URL = 'https://youtu.be/PcLaJ4OnnJs'.freeze
  MP3_URL = 'http://thelot.out.airtime.pro:8000/thelot_a'.freeze

  def self.fetch
    response = HTTParty.get(NOW_PLAYING_ENDPOINT).parsed_response
    current_show = response['shows']['current']
    next_show = response['shows']['next']&.first

    {
      data: {
        stream: {
          youtube_url: YOUTUBE_URL,
          mp3_url: MP3_URL
        },
        current_show: {
          title: current_show ? current_show['name'] : 'N/A'
        },
        next_show: {
          title: next_show ? next_show['name'] : 'N/A'
        }
      }
    }
  end
end
