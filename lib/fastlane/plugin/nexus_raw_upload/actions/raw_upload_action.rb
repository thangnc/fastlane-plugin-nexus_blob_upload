require 'fastlane/action'
require 'fastlane_core/configuration/config_item'
require_relative '../helper/nexus_raw_upload_helper'

module Fastlane
  module Actions
    class RawUploadAction < Action
      def self.run(params)
        args = []
        args << "curl"
        args << verbose(params)
        args << "--fail"
        args += ssl_options(params)
        args += upload_options(params)
        args << upload_url(params)
        command = args.join(' ')

        success = true
        Fastlane::Actions.sh(command, log: params[:verbose], error_callback: -> (result) { success = false })
        UI.user_error "raw_upload failed with status #{$?.exitstatus}: #{command}" unless success
      end

      def self.description
        "Upload a raw asset to [Sonatype Nexus platform](https://www.sonatype.com)"
      end

      def self.authors
        ["Thang Nguyen Cao"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        ""
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :file,
                                       description: "File to be uploaded to Nexus",
                                       optional: false,
                                       verify_block: proc do |value|
                                         file_path = File.expand_path(value)
                                         UI.user_error!("Couldn't find file at path '#{file_path}'") unless File.exist?(file_path)
                                       end),
          FastlaneCore::ConfigItem.new(key: :repository,
                                       description: "Nexus repository e.g. cdn-releases",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :raw_directory,
                                       description: "Nexus raw directory e.g. artifacts",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :file_name,
                                       description: "Nexus file name",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :endpoint,
                                       description: "Nexus endpoint e.g. http://nexus:8081",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :username,
                                       description: "Nexus username",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :password,
                                       description: "Nexus password",
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :ssl_verify,
                                       description: "Verify SSL",
                                       type: Boolean,
                                       default_value: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       description: "Make detailed output",
                                       type: Boolean,
                                       default_value: false,
                                       optional: true)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end

      def self.verbose(params)
        params[:verbose] ? "--verbose" : "--silent"
      end

      def self.ssl_options(params)
        options = []
        unless params[:ssl_verify]
          options << "--insecure"
        end

        options
      end

      def self.upload_options(params)
        file_path = File.expand_path(params[:file]).shellescape

        options = []
        options << "--upload-file #{file_path}"
        options << "-u #{params[:username].shellescape}:#{params[:password].shellescape}"

        options
      end

      def self.upload_url(params)
        file_extension = File.extname(params[:file]).shellescape

        url = (params[:endpoint]).to_s
        url << "/repository/#{params[:repository]}"
        url << "/#{params[:raw_directory]}"
        url << "/#{params[:file_name]}"
        url << file_extension.to_s
        url.shellescape
      end
    end
  end
end
