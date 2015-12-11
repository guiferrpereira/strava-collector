require 'json'
require 'ostruct'
require 'delegate'

module Configurator
  class Configuration < SimpleDelegator
    def initialize filename
      hash = JSON.parse(File.read(filename))

      hash = Hash[hash.map do |k, v|
        [k.underscore, v.deep_symbolize_keys]
      end]

      __setobj__ OpenStruct.new(hash)
    end
  end

  def self.config filename
    Module.new do
      class << self
        def included base
          base.extend self
        end
      end

      define_method(:config) do
        @config ||= Configuration.new(filename)
      end
    end
  end
end

module StravaCollector
  include Configurator.config(::Rails.root.join('config', 'settings.json'))
end
