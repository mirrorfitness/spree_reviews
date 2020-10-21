object @image
attributes :id, :attachment_content_type, :attachment_file_name, :type, :attachment_updated_at, :attachment_width, :attachment_height, :alt
{ medium: '300x300', thumb: '100x100', original: nil }.each do |k, v|
  node("#{k}_url") do |i|
    if i.attachment.attached?
      main_app.url_for(v ? i.attachment.variant(resize: v) : i.attachment)
    end
  end
end
