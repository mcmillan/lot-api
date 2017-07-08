class Mixcloud
  FEED_URL = 'https://api.mixcloud.com/thelotradio/feed/'.freeze

  def shows
    extract_shows(JSON.parse(HTTParty.get(FEED_URL).body))
  end

  private

  def extract_shows(response)
    puts response
    response['data']
      .select { |s| s['type'] == 'upload' && !s['cloudcasts'].empty? }
      .map { |s| normalize_show(s) }
  end

  def normalize_show(show)
    cloudcast = show['cloudcasts'].first

    {
      name: cloudcast['name'].sub(/\s?\@ The Lot Radio.*$/, ''),
      mixcloud_url: cloudcast['url'],
      images: {
        extra_large: cloudcast['pictures']['extra_large'],
        large: cloudcast['pictures']['large'],
        medium: cloudcast['pictures']['medium'],
        small: cloudcast['pictures']['small']
      }
    }
  end
end
