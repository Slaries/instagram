require "image_processing/mini_magick"

  class ImageUploader < Shrine
    include ImageProcessing::MiniMagick
    plugin :processing
    plugin :versions, names: [:original, :thumb]
    plugin :cached_attachment_data
    plugin :validation_helpers
    plugin :remove_attachment
    plugin :restore_cached_data


    Attacher.validate do
      validate_max_size 1.megabytes, message: 'is too large (max is 1 MB)'
      validate_mime_type_inclusion %w[image/jpeg image/jpg image/png image/gif]
    end

    # Process additional versions in background.
    process(:store) do |io|
      versions = {original: io}
      io.download do |original|
        pipeline = ImageProcessing::MiniMagick.source(original)
        versions[:thumb] = pipeline.resize_to_limit!(300,300)
      end
      versions
    end

    Attacher.promote { |data| ShrineBackgrounding::PromoteJob.perform_async(data) }
    Attacher.delete { |data| ShrineBackgrounding::DeleteJob.perform_async(data) }
  end
  #   process(:store) do |io, context|
  #     original = io.download
  #     pipeline = ImageProcessing::MiniMagick.source(original)
  #     size_300 = pipeline.resize_to_limit!(300, 300)
  #     original.close!
  #     { original: io, thumb: size_300 }
  #   end
  #
  #     Attacher.validate do
  #       validate_max_size 1*1024*1024, message: "is too large (max is 1 MB)"
  #       validate_mime_type %w[image/jpeg image/png image/webp], message: "must be JPEG, PNG or WEBP"
  #       validate_min_dimensions [100, 100]
  #       validate_max_dimensions [5000, 5000]
  #     end
  # end
