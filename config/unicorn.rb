root = File.expand_path("../..", __FILE__)

working_directory root

listen "0.0.0.0:80"
worker_processes 2
timeout 30
