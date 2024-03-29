require 'extensions/kernel' if defined?(require_relative).nil?
require_relative 'Block'

module WebBlocks
  module Core
    class BlockFactory
      
      attr_accessor :directories

      def initialize directories
        @directories = directories.select { |directory| File.exists? "#{directory}/Blocksfile.rb" }
      end
      
      def blocksfiles
        directories.map { |directory| directory += "Blocksfile.rb" }
      end

      def names
        @names ||= blocks.keys
      end
      
      def blocks
        @blocks ||= Hash[
          directories.map do |directory|
            block = Block.new directory
            [ block.name, block ]
          end
        ]
      end

    end
  end
end