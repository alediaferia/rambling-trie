module Rambling
  module Trie
    class Container
      extend ::Forwardable

      include ::Enumerable

      delegate [
        :each,
        :add,
        :word?,
        :include?,
        :partial_word?,
        :match?,
        :compress!,
        :compressed?
      ] => :root

      # Creates a new Trie.
      # @param [Root] the root node for the trie
      # @yield [Container] the trie just created.
      def initialize root = nil, compressor = nil
        @root = root || default_root
        @compressor = compressor || default_compressor

        yield self if block_given?
      end

      # Adds a branch to the trie based on the word, without changing the passed word.
      # @param [String] word the word to add the branch from.
      # @return [Node] the just added branch's root node.
      # @raise [InvalidOperation] if the trie is already compressed.
      # @see Branches#add
      # @note Avoids clearing the contents of the word variable.
      def add word
        root.add word.clone
      end

      # Compresses the existing tree using redundant node elimination. Flags the trie as compressed.
      # @return [Container] self
      def compress!
        self.root = compressor.compress root
        self
      end

      alias_method :include?, :word?
      alias_method :match?, :partial_word?
      alias_method :<<, :add

      private

      attr_reader :compressor
      attr_accessor :root

      def default_root
        Rambling::Trie::Root.new
      end

      def default_compressor
        Rambling::Trie::Compressor.new
      end
    end
  end
end
