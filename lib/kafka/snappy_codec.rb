module Kafka
  class SnappyCodec
    def codec_id
      2
    end

    def load
      require "snappy"
    rescue LoadError
      raise LoadError,
        "Using snappy compression requires adding a dependency on the `snappy` gem to your Gemfile."
    end

    def compress(data)
      Snappy.deflate(data)
    end

    def decompress(data)
      buffer = StringIO.new(data)
      Snappy::Reader.new(buffer).read
    end
  end
end
