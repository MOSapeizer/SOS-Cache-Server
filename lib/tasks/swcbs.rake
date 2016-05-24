require_relative 'swcb_rain_task'

task startSwcbRain: :environment do
  Rails.logger       = Logger.new(Rails.root.join('log', 'daemon.log'))
  Rails.logger.level = Logger.const_get((ENV['LOG_LEVEL'] || 'info').upcase)

  if ENV['BACKGROUND']
    Process.daemon(true, true)
  end

  if ENV['PIDFILE']
    File.open(ENV['PIDFILE'], 'w') { |f| f << Process.pid }
  end

  Signal.trap('TERM') { abort }
  Rails.logger.info 'Start Swcb daemon...'

  swcb = SwcbRainTask.new
  puts 'Get Capability into database '
  swcb.save
  puts 'done'

end

task updateSwcbRain: :environment do
  Rails.logger       = Logger.new(Rails.root.join('log', 'daemon.log'))
  Rails.logger.level = Logger.const_get((ENV['LOG_LEVEL'] || 'info').upcase)

  if ENV['BACKGROUND']
    Process.daemon(true, true)
  end

  if ENV['PIDFILE']
    File.open(ENV['PIDFILE'], 'w:UTF-8') { |f| f << Process.pid }
  end
  Signal.trap('TERM') { abort }
  Rails.logger.info 'Start daemon...'

  swcb = SwcbRainTask.new
  puts 'save '
  swcb.clean_cache
  swcb.save_observation
  puts 'done'

end