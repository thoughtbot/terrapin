require 'rspec'
require 'terrapin'
require 'timeout'
require 'tempfile'
require 'pry'
require 'thread'
require 'pathname'

begin; require 'active_support/logger'; rescue LoadError; end
begin; require 'active_support/buffered_logger'; rescue LoadError; end

Dir[File.dirname(__FILE__) + "/support/**.rb"].each{|support_file| require support_file }

RSpec.configure do |config|
  config.include WithExitstatus
  config.include StubOS
end

def best_logger
  if ActiveSupport.const_defined?("Logger")
    ActiveSupport::Logger
  elsif ActiveSupport.const_defined?("BufferedLogger")
    ActiveSupport::BufferedLogger
  else
    Logger
  end
end
