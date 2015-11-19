module StravaCollector
  class Config
    attr_accessor :strava

    def initialize filename
      JSON.parse(File.read(filename)).each do |key, value|
        send("#{key.tr('-', '_')}=", value.deep_symbolize_keys)
      end
    end
  end

  def self.config
    @c ||= Config.new ::Rails.root.join('config', 'settings.json')
  end
end
