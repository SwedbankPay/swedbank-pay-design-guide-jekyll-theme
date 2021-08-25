# frozen_string_literal: true

require 'jekyll'

module SwedbankPay
  # Logs stuff
  module SidebarLogger
    class << self
      def debug(message)
        Jekyll.logger.debug prefix(message)
      end

      def info(message)
        Jekyll.logger.info prefix(message)
      end

      def warn(message)
        Jekyll.logger.warn prefix(message)
      end

      def error(message)
        Jekyll.logger.error prefix(message)
      end

      private

      def prefix(message)
        "           Sidebar: #{message}"
      end
    end
  end
end
