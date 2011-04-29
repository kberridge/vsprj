require_relative './lib/command_runner'

cmd_runner = CommandRunner.new
cmd_runner.run ARGV
