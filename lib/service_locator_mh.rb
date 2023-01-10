# Based on: https://gist.github.com/dajulia3/5479980
# frozen_string_literal: true

require_relative 'service_locator_mh/version'
require 'singleton'

class ServiceLocator
  include Singleton

  def self.reset_instance
    instance_variable_set('@singleton__instance__', send(:new))
  end

  def initialize
    @services = {}
  end

  def register_by_name(service_name, instance)
    @services[service_name] = instance
  end

  def register_by_type(service_type, instance)
    register_by_name(service_type.name, instance)
  end

  def get_service_by_name(service_name)
    service_instance = @services[service_name]
    raise NoSuchServiceInstanceException if service_instance.nil?

    service_instance
  end

  def get_service_by_type(service_type)
    get_service_by_name(service_type.name)
  end

  class NoSuchServiceInstanceException < StandardError; end
end
