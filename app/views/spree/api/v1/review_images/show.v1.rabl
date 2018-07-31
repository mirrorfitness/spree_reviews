object @image
attributes *[ :id, :attachment_content_type, :attachment_file_name, :type, :attachment_updated_at, :attachment_width, :attachment_height, :alt ]
# Spree::Image.attachment_definitions[:attachment][:styles].each do |k, _v|
{ medium: "300x300>", thumb: "100x100>", original: nil }.each do |k, _v|
  node("#{k}_url") { |i| i.attachment.url(k) }
end
