# frozen_string_literal: true

require 'quicken'
require 'quicken/plugins/git/remote'
require 'git'

module Quicken
  module Plugins
    class Git < Quicken::Plugin
      def initialize args
        validate_args args
        parse_path args
        parse_remotes args
      end

      def call
        say "Initializing Git repository in #{@path}"
        git = ::Git.init @path
        @remotes.each do |remote|
          name = remote.name
          url  = remote.url

          if git.remote(name)&.url.present?
            say "Remote repository '#{name}' already exist. Skipping...", :yellow
          else
            r = git.add_remote(name, url)
            say "Adding remote repository '#{r.name}'' with URL '#{r.url}''", :green
          end
        end
      end

      private

      def validate_args args
        @args = args
        return if args.is_a?(String) || bool?(args)
        if args.is_a? Hash
          invalid! unless args[:path].is_a? String
          if args.key? :remote
            remote = args[:remote]
            invalid! unless remote.is_a?(String) || remote.is_a?(Hash)

            if remote.is_a? Hash
              invalid! unless args[:remote].reduce(true) do |valid, couple|
                valid && couple.last.is_a?(String)
              end
            end
          end
        end
      end

      def parse_path args
        return (@path = Dir.pwd) if bool? args
        @path = args.is_a?(String) ? args : (args[:path] || Dir.pwd)
      end

      def parse_remotes args
        @remotes = []
        return if args.is_a?(String) || bool?(args)

        if args.key? :remote
          remote = args[:remote]
          if remote.is_a? String
            add_remote :origin, remote
          elsif remote.is_a? Hash
            remote.each do |rem|
              add_remote rem.first, rem.last
            end
          end
        end
      end

      def add_remote name, url
        remote = Remote.new name, url
        @remotes.push(remote)
      end

      def invalid!
        die "Invalid configuration for Git: #{@args.inspect}"
      end

      def bool? value
        [true, false].include? value
      end
    end
  end
end
