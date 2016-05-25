require_relative 'swcb_task'

task start: :environment do
  Rails.logger       = Logger.new(Rails.root.join('log', 'daemon.log'))
  Rails.logger.level = Logger.const_get((ENV['LOG_LEVEL'] || 'info').upcase)

  if ENV['BACKGROUND']
    Process.daemon(true, true)
  end

  if ENV['PIDFILE']
    File.open(ENV['PIDFILE'], 'w') { |f| f << Process.pid }
  end

  Signal.trap('TERM') { abort }

  Rails.logger.info 'Start daemon...'

  # loop do
    puts 'update '
    update_offering find_all_offerings
    puts 'done'
    # sleep 10 * 60
  # end

end

task startSwcb: :environment do
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

  swcb = SwcbTask.new
  puts 'Get Capability into database '
  swcb.save
  puts 'done'

end

task updateSwcb: :environment do
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

  swcb = SwcbTask.new
  puts 'saving'
  swcb.save_observation
  puts 'done'

end