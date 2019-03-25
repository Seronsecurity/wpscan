# frozen_string_literal: true

module WPScan
  module Model
    # WordPress Plugin
    class Plugin < WpItem
      # See WpItem
      def initialize(slug, blog, opts = {})
        super(slug, blog, opts)

        @uri = Addressable::URI.parse(blog.url("wp-content/plugins/#{slug}/"))

        # To be used by #head_and_get
        # If custom wp-content, it will be replaced by blog#url
        @path_from_blog = "wp-content/plugins/#{slug}/"
      end

      # @return [ JSON ]
      def db_data
        DB::Plugin.db_data(slug)
      end

      # @param [ Hash ] opts
      #
      # @return [ Model::Version, false ]
      def version(opts = {})
        @version = Finders::PluginVersion::Base.find(self, version_detection_opts.merge(opts)) if @version.nil?

        @version
      end
    end
  end
end